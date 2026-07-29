import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/core/types/states/base_command.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/modules/auth/dto/register_with_email_and_password.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_register_with_email_and_password_use_case.dart';

class RegisterWithEmailAndPasswordCommand
    extends BaseCommand<Unit, AppException> {
  RegisterWithEmailAndPasswordCommand({
    required this._registerWithEmailAndPasswordUseCase,
  }) : super(CommandInitial(unit));

  final IRegisterWithEmailAndPasswordUseCase
  _registerWithEmailAndPasswordUseCase;

  Future<void> execute(RegisterWithEmailAndPassword registration) async {
    setState(CommandLoading());

    final result = await _registerWithEmailAndPasswordUseCase.execute(
      registration,
    );

    result.when(
      onSuccess: (value) => setState(CommandSuccess(value)),
      onFailure: (exception) => setState(CommandFailure(exception)),
    );
  }

  @override
  void reset() => setState(CommandInitial(unit));
}
