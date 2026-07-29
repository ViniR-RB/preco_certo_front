import 'package:dio/dio.dart';
import 'package:preco_certo/app/core/data/rest_client/rest_client.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/modules/auth/data/exceptions/auth_repository_exception.dart';
import 'package:preco_certo/app/modules/auth/data/repositories/i_auth_repository.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/dto/register_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/models/auth_tokens.dart';
import 'package:preco_certo/app/modules/auth/models/user_model.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final RestClient _restClient;

  AuthRepositoryImpl({required this._restClient});

  @override
  AsyncResult<AppException, AuthTokens> loginWithEmailAndPassword(
    CredentialsWithEmailAndPassword credentials,
  ) async {
    try {
      final Response(:data) = await _restClient.unAuth.post(
        "/api/auth/login",
        data: credentials.toJson(),
      );

      return Success(AuthTokens.fromJson(data));
    } on DioException catch (e) {
      return switch (e) {
        DioException(response: Response(statusCode: 422)) => Failure(
          AuthRepositoryException.invalidCredentials(),
        ),
        DioException(
          response: Response(
            statusCode: 400,
            data: {"message": "Invalid email or password"},
          ),
        ) =>
          Failure(AuthRepositoryException.invalidCredentials()),
        DioException(response: Response(statusCode: 404)) => Failure(
          AuthRepositoryException.invalidCredentials(),
        ),
        DioException(response: Response(statusCode: 401)) => Failure(
          AuthRepositoryException.invalidCredentials(),
        ),
        _ => throw e,
      };
    }
  }

  @override
  AsyncResult<AppException, Unit> registerWithEmailAndPassword(
    RegisterWithEmailAndPassword registerWithEmailAndPassword,
  ) async {
    try {
      await _restClient.unAuth.post(
        "/api/auth/register/user",
        data: registerWithEmailAndPassword.toJson(),
      );
      return Success(unit);
    } on DioException catch (e) {
      return switch (e) {
        DioException(response: Response(statusCode: 422)) => Failure(
          AuthRepositoryException.invalidCredentials(),
        ),
        DioException(response: Response(statusCode: 409)) => Failure(
          AuthRepositoryException.invalidCredentials(),
        ),
        _ => throw e,
      };
    }
  }

  @override
  AsyncResult<AppException, UserModel> whoIam() async {
    try {
      final Response(:data) = await _restClient.auth.auth.get("/api/auth/me");

      return Success(UserModel.fromJson(data));
    } on DioException catch (e) {
      return switch (e) {
        _ => throw e,
      };
    }
  }
}
