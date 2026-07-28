import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:preco_certo/app/core/extensions/error_translator.dart';
import 'package:preco_certo/app/core/extensions/theme_extension.dart';
import 'package:preco_certo/app/core/session/app_session_controller.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/core/widgets/app_snack_bar.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';
import 'package:preco_certo/app/modules/offers/ui/get_products_command.dart';
import 'package:preco_certo/app/modules/offers/ui/offers_controller.dart';
import 'package:preco_certo/gen/assets.gen.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  State<OffersPage> createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage>
    with ErrorTranslator<OffersPage> {
  late final GetProductsCommand _getProductsCommand;

  @override
  void initState() {
    super.initState();
    _getProductsCommand = context.read<GetProductsCommand>()
      ..addListener(_handleProductsState);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _getProductsCommand.execute();
      }
    });
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

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: RefreshIndicator(
              onRefresh: _getProductsCommand.execute,
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
                            'OFERTAS PERTO DE VOCÊ',
                            style: text.eyebrow.copyWith(color: colors.accent),
                          ),
                          const SizedBox(height: 10),
                          Text('Compre melhor hoje.', style: text.display),
                          const SizedBox(height: 24),
                          TextField(
                            onChanged: controller.setSearch,
                            decoration: const InputDecoration(
                              hintText: 'Buscar produto',
                              prefixIcon: Icon(Icons.search),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text('Ofertas para sua lista', style: text.heading),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  _OffersContent(
                    command: command,
                    controller: controller,
                    onRetry: _getProductsCommand.execute,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavigation(),
    );
  }
}

String _initials(String? name) {
  final words = name?.trim().split(RegExp(r'\s+')) ?? const <String>[];
  return words.where((word) => word.isNotEmpty).take(2).map((word) => word[0]).join().toUpperCase();
}

class _OffersContent extends StatelessWidget {
  const _OffersContent({
    required this.command,
    required this.controller,
    required this.onRetry,
  });

  final GetProductsCommand command;
  final OffersController controller;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return switch (command.state) {
      CommandInitial() || CommandLoading() => const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      ),
      CommandFailure() => SliverFillRemaining(
        hasScrollBody: false,
        child: _EmptyState(
          title: 'Não foi possível carregar as ofertas.',
          action: OutlinedButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar novamente'),
          ),
        ),
      ),
      CommandSuccess() when controller.products.isEmpty => SliverFillRemaining(
        hasScrollBody: false,
        child: _EmptyState(
          title: controller.hasSearch
              ? 'Nenhuma oferta encontrada.'
              : 'Ainda não há ofertas perto de você.',
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
          ),
          separatorBuilder: (_, _) => const SizedBox(height: 14),
        ),
      ),
    };
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.product,
    required this.selected,
    required this.onAdd,
  });

  final Product product;
  final bool selected;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colors;
    final text = theme.text;
    final price = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

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
                    placeholder: (_, _) => Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colors.offer,
                        ),
                      ),
                    ),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: text.heading.copyWith(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton.filled(
                        onPressed: onAdd,
                        style: IconButton.styleFrom(
                          backgroundColor: colors.offer,
                          foregroundColor: colors.onAccent,
                          minimumSize: const Size(40, 40),
                        ),
                        tooltip: selected
                            ? 'Remover da lista'
                            : 'Adicionar à lista',
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
                            style: text.body.copyWith(
                              fontSize: 14,
                              color: colors.muted,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: colors.muted,
                              decorationThickness: 1.5,
                            ),
                          ),
                        if (product.hasDiscount) const SizedBox(height: 3),
                        RichText(
                          text: TextSpan(
                            style: text.body.copyWith(color: colors.muted),
                            children: [
                              const TextSpan(text: 'por '),
                              TextSpan(
                                text: price.format(product.lowestPriceValue),
                                style: text.price.copyWith(color: colors.offer),
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_offer_outlined, size: 44, color: theme.colors.muted),
          const SizedBox(height: 14),
          Text(title, style: theme.text.heading, textAlign: TextAlign.center),
          if (action != null) ...[const SizedBox(height: 16), action!],
        ],
      ),
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Início',
        ),
        NavigationDestination(
          icon: Icon(Icons.list_alt_outlined),
          selectedIcon: Icon(Icons.list_alt),
          label: 'Lista',
        ),
      ],
    );
  }
}
