import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/modules/auth/data/repositories/auth_repository_impl.dart';
import 'package:preco_certo/app/modules/auth/data/repositories/i_auth_repository.dart';
import 'package:preco_certo/app/modules/auth/data/services/login_with_email_and_password_service.dart';
import 'package:preco_certo/app/modules/auth/data/services/register_with_email_and_password_service.dart';
import 'package:preco_certo/app/modules/auth/ui/login/login_controller.dart';
import 'package:preco_certo/app/modules/auth/ui/login/login_page.dart';
import 'package:preco_certo/app/modules/auth/ui/login/login_with_email_and_password_command.dart';
import 'package:preco_certo/app/modules/auth/ui/register/register_page.dart';
import 'package:preco_certo/app/modules/auth/ui/register/register_with_email_and_password_command.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_login_with_email_and_password_use_case.dart';
import 'package:preco_certo/app/modules/auth/usecase/i_register_with_email_and_password_use_case.dart';

final authModule = createModule(
  register: (ModularContext c) {
    c
      ..route(
        '/login',
        provide: (s) => s
          ..addChangeNotifier<LoginController>(LoginController.new)
          ..addChangeNotifier<LoginWithEmailAndPasswordCommand>(
            LoginWithEmailAndPasswordCommand.new,
          ),
        child: (_, _) => const LoginPage(),
      )
      ..route(
        '/register',
        provide: (s) =>
            s.addChangeNotifier<RegisterWithEmailAndPasswordCommand>(
              RegisterWithEmailAndPasswordCommand.new,
            ),
        child: (_, _) => const RegisterPage(),
      )
      ..addLazySingleton<IAuthRepository>(AuthRepositoryImpl.new)
      ..addLazySingleton<ILoginWithEmailAndPasswordUseCase>(
        LoginWithEmailAndPasswordService.new,
      )
      ..addLazySingleton<IRegisterWithEmailAndPasswordUseCase>(
        RegisterWithEmailAndPasswordService.new,
      );
  },
);
