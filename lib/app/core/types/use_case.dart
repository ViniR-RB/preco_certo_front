import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';

abstract interface class UseCase<Param, Success> {
  AsyncResult<AppException, Success> execute(Param param);
}
