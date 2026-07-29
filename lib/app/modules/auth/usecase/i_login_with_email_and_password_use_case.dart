import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/core/types/use_case.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';

abstract interface class ILoginWithEmailAndPasswordUseCase
    implements UseCase<CredentialsWithEmailAndPassword, Unit> {}
