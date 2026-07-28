import 'package:preco_certo/app/core/config/constants.dart';
import 'package:preco_certo/app/core/data/local_storage/i_local_storage_service.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/session/app_session_controller.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/modules/auth/data/repositories/i_auth_repository.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_login_with_email_and_password_use_case.dart';

class LoginWithEmailAndPasswordService
    implements ILoginWithEmailAndPasswordUseCase {
  final IAuthRepository _authRepository;
  final ILocalStorageService _localStorageService;
  final AppSessionController _appSessionController;

  LoginWithEmailAndPasswordService({
    required this._authRepository,
    required this._localStorageService,
    required this._appSessionController,
  });

  @override
  AsyncResult<AppException, Unit> execute(
    CredentialsWithEmailAndPassword credentials,
  ) {
    return _authRepository
        .loginWithEmailAndPassword(credentials)
        .flatMap(
          (authTokens) => _localStorageService
              .set(Constants.accessToken, authTokens.accessToken)
              .flatMap(
                (_) => _localStorageService.set(
                  Constants.refreshToken,
                  authTokens.refreshToken,
                ),
              ),
        )
        .flatMap(
          (_) => _authRepository.whoIam().flatMap(
            (user) =>
                _localStorageService.set(Constants.userKey, user.encode()).map((_) { _appSessionController.setUser(user); return unit; }),
          ),
        );
  }
}
