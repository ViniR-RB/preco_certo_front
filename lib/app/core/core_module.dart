import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:preco_certo/app/core/data/local_storage/i_local_storage_service.dart';
import 'package:preco_certo/app/core/data/local_storage/local_storage_service_impl.dart';
import 'package:preco_certo/app/core/data/rest_client/rest_client.dart';
import 'package:preco_certo/app/core/session/app_session_controller.dart';

final coreModule = createModule(
  register: (ModularContext c) {
    c
      ..addLazySingleton<AppSessionController>(AppSessionController.new)
      ..addLazySingleton<RestClient>(RestClient.new)
      ..addLazySingleton<ILocalStorageService>(
        () => LocalStorageServiceImpl(storage: FlutterSecureStorage()),
      );
  },
);
