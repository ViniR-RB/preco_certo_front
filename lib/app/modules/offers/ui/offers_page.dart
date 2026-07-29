import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/extensions/error_translator.dart';
import 'package:preco_certo/app/core/extensions/loader_message.dart';
import 'package:preco_certo/app/core/extensions/message_translator.dart';
import 'package:preco_certo/app/core/extensions/theme_extension.dart';
import 'package:preco_certo/app/core/session/app_session_controller.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/core/widgets/app_snack_bar.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';
import 'package:preco_certo/app/modules/offers/ui/get_products_command.dart';
import 'package:preco_certo/app/modules/offers/ui/offers_controller.dart';
import 'package:preco_certo/gen/assets.gen.dart';
import 'package:preco_certo/l10n/app_localizations.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage>
    with
        ErrorTranslator<OffersPage>,
        MessageTranslator<OffersPage>,
        LoaderMessageMixin<OffersPage> {
  late final GetProductsCommand _getProductsCommand;

  @override
  void initState() {
    super.initState();
    _getProductsCommand = context.read<GetProductsCommand>()
      ..addListener(_handleProductsState);
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    final controller = context.read<OffersController>();
    notifier.showLoader();
    final result = await controller.loadLocation();
    if (!mounted) return;
    notifier.hideLoader();
    result.when(
      onSuccess: (location) {
        if (location == null) {
          _openLocationSheet(required: true);
        } else {
          _getProductsCommand.execute(location);
        }
      },
      onFailure: (exception) => AppSnackBar.show(
        context,
        message: translateError(exception),
        type: SnackType.error,
      ),
    );
  }

  void _handleProductsState() {
    if (!mounted) return;
    switch (_getProductsCommand.state) {
      case CommandSuccess(:final value):
        context.read<OffersController>().setProducts(value);
      case CommandFailure(:final exception):
        AppSnackBar.show(
          context,
          message: translateError(exception),
          type: SnackType.error,
        );
      case CommandInitial() || CommandLoading():
        break;
    }
  }

  Future<void> _reloadOffers() async {
    final location = context.read<OffersController>().location;
    if (location != null) await _getProductsCommand.execute(location);
  }

  Future<void> _openLocationSheet({bool required = false}) async {
    final controller = context.read<OffersController>();
    controller.hideAddressSearch();
    final addressController = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: !required,
      enableDrag: !required,
      builder: (sheetContext) => ListenableBuilder(
        listenable: controller,
        builder: (_, _) => Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            12,
            24,
            MediaQuery.viewInsetsOf(sheetContext).bottom + 28,
          ),
          child: SingleChildScrollView(
            child: _LocationSheet(
              location: controller.location,
              suggestions: controller.addressSuggestions,
              isAddressSearchVisible: controller.isAddressSearchVisible,
              translate: (code) => translateMessage(context, code),
              onDeviceLocation: () async {
                notifier.showLoader();
                final result = await controller.useDeviceLocation();
                if (!mounted) return;
                notifier.hideLoader();
                result.when(
                  onSuccess: (location) {
                    sheetContext.pop();
                    _getProductsCommand.execute(location);
                  },
                  onFailure: (exception) => AppSnackBar.show(
                    context,
                    message: translateMessage(context, exception.code),
                    type: SnackType.error,
                  ),
                );
              },
              onSearchAddress: () async {
                final query = addressController.text.trim();
                if (query.isEmpty) return;
                final result = await controller.searchAddress(query);
                if (!mounted) return;
                result.when(
                  onSuccess: (_) {},
                  onFailure: (exception) => AppSnackBar.show(
                    context,
                    message: translateMessage(context, exception.code),
                    type: SnackType.error,
                  ),
                );
              },
              onShowAddressSearch: controller.showAddressSearch,
              onSelectAddress: (address) async {
                final result = await controller.selectAddress(address);
                if (!mounted) return;
                result.when(
                  onSuccess: (location) {
                    sheetContext.pop();
                    _getProductsCommand.execute(location);
                  },
                  onFailure: (exception) => AppSnackBar.show(
                    context,
                    message: translateError(exception),
                    type: SnackType.error,
                  ),
                );
              },
              onRadiusChanged: (radius) async {
                await controller.setRadius(radius);
                final location = controller.location;
                if (location != null) _getProductsCommand.execute(location);
              },
              addressController: addressController,
              showClose: !required,
            ),
          ),
        ),
      ),
    );
    addressController.dispose();
  }

  @override
  void dispose() {
    _getProductsCommand.removeListener(_handleProductsState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final text = theme.text;
    final controller = context.watch<OffersController>();
    final command = context.watch<GetProductsCommand>();
    final location = controller.location;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: RefreshIndicator(
              onRefresh: _reloadOffers,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Assets.logo.image(
                                height: 42,
                                fit: BoxFit.contain,
                                semanticLabel: 'Preço Certo',
                              ),
                              CircleAvatar(
                                backgroundColor: colors.accent,
                                foregroundColor: colors.onAccent,
                                child: Text(
                                  _initials(
                                    inject<AppSessionController>().user?.name,
                                  ),
                                  style: text.label.copyWith(
                                    color: colors.onAccent,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 34),
                          Text(
                            translateMessage(
                              context,
                              MessageConstants.offersEyebrow,
                            ),
                            style: text.eyebrow.copyWith(color: colors.accent),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            translateMessage(
                              context,
                              MessageConstants.offersTitle,
                            ),
                            style: text.display,
                          ),
                          const SizedBox(height: 24),
                          _LocationTrigger(
                            label:
                                location?.label ??
                                translateMessage(
                                  context,
                                  MessageConstants.offersLocationUnset,
                                ),
                            detail: location == null
                                ? translateMessage(
                                    context,
                                    MessageConstants.offersLocationHint,
                                  )
                                : '${translateMessage(context, MessageConstants.offersListSubtitle)} ${location.radius} km',
                            onPressed: _openLocationSheet,
                          ),
                          const SizedBox(height: 18),
                          TextField(
                            onChanged: controller.setSearch,
                            decoration: InputDecoration(
                              hintText: translateMessage(
                                context,
                                MessageConstants.offersSearchHint,
                              ),
                              prefixIcon: const Icon(Icons.search),
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            translateMessage(
                              context,
                              MessageConstants.offersListTitle,
                            ),
                            style: text.heading,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            translateMessage(
                              context,
                              MessageConstants.offersListSubtitle,
                            ),
                            style: text.body.copyWith(color: colors.muted),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  _OffersContent(
                    command: command,
                    controller: controller,
                    onRetry: _reloadOffers,
                    noResults: translateMessage(
                      context,
                      MessageConstants.offersNoResults,
                    ),
                    noSearchResults: translateMessage(
                      context,
                      MessageConstants.offersNoSearchResults,
                    ),
                    loadFailure: translateMessage(
                      context,
                      MessageConstants.offersLoadFailure,
                    ),
                    retry: translateMessage(
                      context,
                      MessageConstants.offersRetry,
                    ),
                    add: translateMessage(context, MessageConstants.offersAdd),
                    remove: translateMessage(
                      context,
                      MessageConstants.offersRemove,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavigation(
        home: translateMessage(context, MessageConstants.offersHome),
        list: translateMessage(context, MessageConstants.offersList),
      ),
    );
  }
}

class _LocationSheet extends StatelessWidget {
  const _LocationSheet({
    required this.location,
    required this.suggestions,
    required this.isAddressSearchVisible,
    required this.translate,
    required this.onDeviceLocation,
    required this.onSearchAddress,
    required this.onShowAddressSearch,
    required this.onSelectAddress,
    required this.onRadiusChanged,
    required this.addressController,
    required this.showClose,
  });
  final OffersLocation? location;
  final List<AddressSuggestion> suggestions;
  final bool isAddressSearchVisible;
  final String Function(String) translate;
  final Future<void> Function() onDeviceLocation;
  final Future<void> Function() onSearchAddress;
  final VoidCallback onShowAddressSearch;
  final Future<void> Function(AddressSuggestion) onSelectAddress;
  final Future<void> Function(int) onRadiusChanged;
  final TextEditingController addressController;
  final bool showClose;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Center(
        child: Container(
          width: 42,
          height: 5,
          decoration: BoxDecoration(
            color: Theme.of(context).colors.border,
            borderRadius: BorderRadius.circular(99),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translate(MessageConstants.offersLocationTitle),
                  style: Theme.of(context).text.heading,
                ),
                const SizedBox(height: 7),
                Text(
                  translate(MessageConstants.offersLocationSubtitle),
                  style: Theme.of(
                    context,
                  ).text.body.copyWith(color: Theme.of(context).colors.muted),
                ),
              ],
            ),
          ),
          if (showClose)
            IconButton(onPressed: context.pop, icon: const Icon(Icons.close)),
        ],
      ),
      const SizedBox(height: 14),
      _LocationChoice(
        icon: Icons.my_location_outlined,
        title: translate(MessageConstants.offersUseDeviceLocation),
        detail: translate(MessageConstants.offersUseDeviceLocationHint),
        onTap: onDeviceLocation,
      ),
      _LocationChoice(
        icon: Icons.search,
        title: translate(MessageConstants.offersUseAddress),
        detail: translate(MessageConstants.offersUseAddressHint),
        onTap: () async => onShowAddressSearch(),
      ),
      const SizedBox(height: 16),
      Text(
        translate(MessageConstants.offersRadiusLabel),
        style: Theme.of(context).text.label,
      ),
      const SizedBox(height: 8),
      DropdownButtonFormField<int>(
        initialValue: location?.radius ?? 5,
        items: OffersLocation.allowedRadii
            .map(
              (radius) =>
                  DropdownMenuItem(value: radius, child: Text('$radius km')),
            )
            .toList(),
        onChanged: (radius) {
          if (radius != null) onRadiusChanged(radius);
        },
      ),
      const SizedBox(height: 8),
      Text(
        translate(MessageConstants.offersRadiusHint),
        style: Theme.of(context).text.body.copyWith(
          fontSize: 12,
          color: Theme.of(context).colors.muted,
        ),
      ),
      if (isAddressSearchVisible) ...[
        const SizedBox(height: 16),
        Text(
          translate(MessageConstants.offersAddressLabel),
          style: Theme.of(context).text.label,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: addressController,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) {
            onSearchAddress();
          },
          decoration: InputDecoration(
            hintText: translate(MessageConstants.offersAddressHint),
          ),
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: onSearchAddress,
          child: Text(translate(MessageConstants.offersSearchAddress)),
        ),
      ],
      if (suggestions.isNotEmpty) ...[
        const SizedBox(height: 18),
        Text(
          translate(MessageConstants.offersAddressResults),
          style: Theme.of(context).text.label,
        ),
        const SizedBox(height: 8),
        ...suggestions.map(
          (address) => ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.location_on_outlined),
            title: Text(address.label),
            onTap: () {
              onSelectAddress(address);
            },
          ),
        ),
      ],
    ],
  );
}

class _LocationChoice extends StatelessWidget {
  const _LocationChoice({
    required this.icon,
    required this.title,
    required this.detail,
    required this.onTap,
  });
  final IconData icon;
  final String title, detail;
  final Future<void> Function() onTap;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          Text(
            detail,
            style: Theme.of(context).text.body.copyWith(
              fontSize: 12,
              color: Theme.of(context).colors.muted,
            ),
          ),
        ],
      ),
      style: OutlinedButton.styleFrom(
        alignment: Alignment.centerLeft,
        minimumSize: const Size.fromHeight(68),
      ),
    ),
  );
}

class _LocationTrigger extends StatelessWidget {
  const _LocationTrigger({
    required this.label,
    required this.detail,
    required this.onPressed,
  });
  final String label, detail;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: const Icon(Icons.location_on_outlined),
    label: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Text(
          detail,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).text.body.copyWith(
            fontSize: 12,
            color: Theme.of(context).colors.muted,
          ),
        ),
      ],
    ),
    style: OutlinedButton.styleFrom(
      alignment: Alignment.centerLeft,
      minimumSize: const Size.fromHeight(58),
    ),
  );
}

String _initials(String? name) =>
    (name?.trim().split(RegExp(r'\s+')) ?? const <String>[])
        .where((word) => word.isNotEmpty)
        .take(2)
        .map((word) => word[0])
        .join()
        .toUpperCase();

class _OffersContent extends StatelessWidget {
  const _OffersContent({
    required this.command,
    required this.controller,
    required this.onRetry,
    required this.noResults,
    required this.noSearchResults,
    required this.loadFailure,
    required this.retry,
    required this.add,
    required this.remove,
  });
  final GetProductsCommand command;
  final OffersController controller;
  final Future<void> Function() onRetry;
  final String noResults, noSearchResults, loadFailure, retry, add, remove;
  @override
  Widget build(BuildContext context) => switch (command.state) {
    CommandInitial() || CommandLoading() => const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(child: CircularProgressIndicator()),
    ),
    CommandFailure() => SliverFillRemaining(
      hasScrollBody: false,
      child: _EmptyState(
        title: loadFailure,
        action: OutlinedButton.icon(
          onPressed: onRetry,
          icon: const Icon(Icons.refresh),
          label: Text(retry),
        ),
      ),
    ),
    CommandSuccess() when controller.products.isEmpty => SliverFillRemaining(
      hasScrollBody: false,
      child: _EmptyState(
        title: controller.hasSearch ? noSearchResults : noResults,
      ),
    ),
    CommandSuccess() => SliverPadding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
      sliver: SliverList.separated(
        itemCount: controller.products.length,
        itemBuilder: (_, index) => _OfferCard(
          product: controller.products[index],
          selected: controller.isSelected(controller.products[index]),
          onAdd: () => controller.toggleProduct(controller.products[index]),
          add: add,
          remove: remove,
        ),
        separatorBuilder: (_, _) => const SizedBox(height: 14),
      ),
    ),
  };
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.product,
    required this.selected,
    required this.onAdd,
    required this.add,
    required this.remove,
  });
  final Product product;
  final bool selected;
  final VoidCallback onAdd;
  final String add, remove;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final price = NumberFormat.currency(
      locale: AppLocalizations.of(context)?.localeName,
    );
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            width: 104,
            height: 132,
            color: colors.background,
            alignment: Alignment.center,
            child: product.image == null
                ? Icon(
                    Icons.shopping_bag_outlined,
                    color: colors.offer,
                    size: 38,
                  )
                : CachedNetworkImage(
                    imageUrl: product.image!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (_, _, _) => Icon(
                      Icons.shopping_bag_outlined,
                      color: colors.offer,
                      size: 38,
                    ),
                  ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.text.heading.copyWith(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filled(
                        onPressed: onAdd,
                        style: IconButton.styleFrom(
                          backgroundColor: colors.offer,
                          foregroundColor: colors.onAccent,
                        ),
                        tooltip: selected ? remove : add,
                        icon: Icon(selected ? Icons.check : Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (product.lowestPriceValue != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.hasDiscount)
                          Text(
                            'de ${price.format(product.highestPriceValue)}',
                            style: theme.text.body.copyWith(
                              fontSize: 14,
                              color: colors.muted,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        if (product.hasDiscount) const SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            style: theme.text.body.copyWith(
                              color: colors.muted,
                            ),
                            children: [
                              const TextSpan(text: 'por '),
                              TextSpan(
                                text: price.format(product.lowestPriceValue),
                                style: theme.text.price.copyWith(
                                  color: colors.offer,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.title, this.action});
  final String title;
  final Widget? action;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.local_offer_outlined,
          size: 44,
          color: Theme.of(context).colors.muted,
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: Theme.of(context).text.heading,
          textAlign: TextAlign.center,
        ),
        if (action != null) ...[const SizedBox(height: 16), action!],
      ],
    ),
  );
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation({required this.home, required this.list});
  final String home, list;
  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: 0,
    destinations: [
      NavigationDestination(
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home),
        label: home,
      ),
      NavigationDestination(
        icon: const Icon(Icons.list_alt_outlined),
        selectedIcon: const Icon(Icons.list_alt),
        label: list,
      ),
    ],
  );
}
