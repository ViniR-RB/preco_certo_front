import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';

class AuthRepositoryException extends AppException {
  AuthRepositoryException(super.code, [super.message, super.stackTrace]);

  factory AuthRepositoryException.unknownError([
    String? message,
    StackTrace? stackTrace,
  ]) {
    return AuthRepositoryException(
      MessageConstants.unknownError,
      message,
      stackTrace,
    );
  }

  factory AuthRepositoryException.invalidCredentials([
    String? message,
    StackTrace? stackTrace,
  ]) {
    return AuthRepositoryException(
      MessageConstants.invalidCredentials,
      message,
      stackTrace,
    );
  }
}
