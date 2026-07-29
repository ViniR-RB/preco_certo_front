import 'package:flutter/foundation.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';

class LoginController extends ChangeNotifier {
  final CredentialsWithEmailAndPassword _credentials =
      CredentialsWithEmailAndPassword(email: "", password: "");
  final CredentialsWithEmailAndPasswordValidator _validator =
      CredentialsWithEmailAndPasswordValidator();

  bool _isPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;

  CredentialsWithEmailAndPassword get credentials => _credentials;

  String? validateEmail(String? value) {
    _credentials.newEmail = value ?? '';
    return _validator.byField(_credentials, 'email')(value);
  }

  String? validatePassword(String? value) {
    _credentials.newPassword = value ?? '';
    return _validator.byField(_credentials, 'password')(value);
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
