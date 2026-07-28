import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:preco_certo/app/core/config/enviroment_variables.dart';
import 'package:preco_certo/app/core/data/local_storage/i_local_storage_service.dart';
import 'package:preco_certo/app/core/data/rest_client/interceptors/auth_interceptor.dart';

class RestClient extends DioForNative {
  RestClient({required ILocalStorageService localStorageService})
    : super(
        BaseOptions(
          baseUrl: EnviromentVariables.apiUrl,
          connectTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      ) {
    interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        requestHeader: false,
      ),
      AuthInterceptor(
        localStorageService: localStorageService,
        restClient: this,
      ),
    ]);
  }

  RestClient get auth {
    options.extra.addAll({"DIO_AUTH_KEY": true});
    return this;
  }

  RestClient get unAuth {
    options.extra.remove("DIO_AUTH_KEY");
    return this;
  }
}
