import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/dto/register_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/models/auth_tokens.dart';
import 'package:preco_certo/app/modules/auth/models/user_model.dart';

abstract interface class IAuthRepository {
  AsyncResult<AppException, AuthTokens> loginWithEmailAndPassword(
    CredentialsWithEmailAndPassword credentials,
  );
  AsyncResult<AppException, Unit> registerWithEmailAndPassword(
    RegisterWithEmailAndPassword registerWithEmailAndPassword,
  );

  AsyncResult<AppException, UserModel> whoIam();
}
