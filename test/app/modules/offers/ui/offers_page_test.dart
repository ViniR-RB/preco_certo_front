import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/session/app_session_controller.dart';
import 'package:preco_certo/app/core/themes/app_theme.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/core/widgets/app_loading_widget.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_offers_location_repository.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';
import 'package:preco_certo/app/modules/offers/ui/get_products_command.dart';
import 'package:preco_certo/app/modules/offers/ui/offers_controller.dart';
import 'package:preco_certo/app/modules/offers/ui/offers_page.dart';
import 'package:preco_certo/app/modules/offers/usecase/i_get_products_use_case.dart';
import 'package:preco_certo/l10n/app_localizations.dart';

import '../constants/offers_test_constants.dart';
import '../mock/offers_mocks.dart';

void main() {
  late MockOffersLocationRepository locationRepository;
  late MockGetProductsUseCase getProductsUseCase;

  setUpAll(() {
    registerFallbackValue(FakeOffersLocation());
  });

  setUp(() {
    locationRepository = MockOffersLocationRepository();
    getProductsUseCase = MockGetProductsUseCase();
  });

  testWidgets('adds a device location after showing the loader', (
    tester,
  ) async {
    // ARRANGE
    await tester.binding.setSurfaceSize(const Size(800, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final locationResult = Completer<Either<AppException, OffersLocation>>();
    when(
      () => locationRepository.load(),
    ).thenAnswer((_) async => Success(null));
    when(
      () => locationRepository.deviceLocation(radius: 5),
    ).thenAnswer((_) => locationResult.future);
    when(
      () => getProductsUseCase.execute(any()),
    ).thenAnswer((_) async => Success(const []));

    final module = createModule(
      register: (context) => context
        ..addSingleton<IOffersLocationRepository>(() => locationRepository)
        ..addSingleton<IGetProductsUseCase>(() => getProductsUseCase)
        ..addSingleton<AppSessionController>(AppSessionController.new)
        ..route(
          '/',
          provide: (scope) => scope
            ..addChangeNotifier<OffersController>(OffersController.new)
            ..addChangeNotifier<GetProductsCommand>(GetProductsCommand.new),
          child: (_, _) => const OffersPage(),
        ),
    );

    await tester.pumpWidget(_OffersTestApp(module: module));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // ACT
    final deviceLocationButton = find.text('Usar localização do aparelho');
    final button = tester.widget<OutlinedButton>(
      find.ancestor(
        of: deviceLocationButton,
        matching: find.byType(OutlinedButton),
      ),
    );
    button.onPressed!();
    await tester.pump();
    await tester.pump();

    // ASSERT
    expect(find.byType(AppLoadingWidget), findsOneWidget);

    locationResult.complete(Success(OffersTestConstants.location));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text(OffersTestConstants.location.label), findsOneWidget);
    verify(() => locationRepository.deviceLocation(radius: 5)).called(1);
    verify(() => getProductsUseCase.execute(any())).called(1);
  });
}

class _OffersTestApp extends StatelessWidget {
  const _OffersTestApp({required this.module});

  final Module module;

  @override
  Widget build(BuildContext context) => ModularApp(
    module: module,
    child: Builder(
      builder: (context) => MaterialApp.router(
        locale: const Locale('pt'),
        theme: appTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: ModularApp.routerConfigOf(context),
      ),
    ),
  );
}
