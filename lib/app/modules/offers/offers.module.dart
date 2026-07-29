import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/core/session/app_session_controller.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_products_repository.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_offers_location_repository.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/offers_location_repository_impl.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/products_repository_impl.dart';
import 'package:preco_certo/app/modules/offers/data/services/get_products_service.dart';
import 'package:preco_certo/app/modules/offers/ui/get_products_command.dart';
import 'package:preco_certo/app/modules/offers/ui/offers_controller.dart';
import 'package:preco_certo/app/modules/offers/ui/offers_page.dart';
import 'package:preco_certo/app/modules/offers/usecase/i_get_products_use_case.dart';

final offersModule = createModule(
  register: (ModularContext c) {
    c
      ..route(
        '/offers',
        provide: (s) => s
          ..addChangeNotifier<OffersController>(OffersController.new)
          ..addChangeNotifier<GetProductsCommand>(GetProductsCommand.new),
        child: (_, _) => const OffersPage(),
        guards: [
          (_) => inject<AppSessionController>().isLogged ? null : '/login',
        ],
      )
      ..addLazySingleton<IProductsRepository>(ProductsRepositoryImpl.new)
      ..addLazySingleton<IOffersLocationRepository>(
        OffersLocationRepositoryImpl.new,
      )
      ..addLazySingleton<IGetProductsUseCase>(GetProductsService.new);
  },
);
