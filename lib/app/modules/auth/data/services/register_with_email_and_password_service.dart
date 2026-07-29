import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/modules/auth/data/repositories/i_auth_repository.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/dto/register_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_login_with_email_and_password_use_case.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_register_with_email_and_password_use_case.dart';

class RegisterWithEmailAndPasswordService
    implements IRegisterWithEmailAndPasswordUseCase {
  RegisterWithEmailAndPasswordService({
    required this._loginWithEmailAndPasswordUseCase,
    required this._authRepository,
  });

  final ILoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;
  final IAuthRepository _authRepository;

  @override
  AsyncResult<AppException, Unit> execute(RegisterWithEmailAndPassword param) {
    return _authRepository
        .registerWithEmailAndPassword(param)
        .flatMap(
          (_) => _loginWithEmailAndPasswordUseCase.execute(
            CredentialsWithEmailAndPassword(
              email: param.email,
              password: param.password,
            ),
          ),
        );
  }
}
