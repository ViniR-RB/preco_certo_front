import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';

abstract interface class ILocalStorageService {
  AsyncResult<AppException, String> get(String key);
  AsyncResult<AppException, Unit> set(String key, String value);
  AsyncResult<AppException, Unit> remove(String key);
}
