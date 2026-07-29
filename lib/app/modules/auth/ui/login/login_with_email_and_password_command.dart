import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/core/types/states/base_command.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_login_with_email_and_password_use_case.dart';

class LoginWithEmailAndPasswordCommand extends BaseCommand<Unit, AppException> {
  LoginWithEmailAndPasswordCommand({
    required this._loginWithEmailAndPasswordUseCase,
  }) : super(CommandInitial(unit));

  final ILoginWithEmailAndPasswordUseCase _loginWithEmailAndPasswordUseCase;

  Future<void> execute(CredentialsWithEmailAndPassword credentials) async {
    setState(CommandLoading());

    final result = await _loginWithEmailAndPasswordUseCase.execute(credentials);

    result.when(
      onSuccess: (value) => setState(CommandSuccess(value)),
      onFailure: (exception) => setState(CommandFailure(exception)),
    );
  }

  @override
  void reset() => setState(CommandInitial(unit));
}
