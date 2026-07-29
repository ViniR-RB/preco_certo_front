import 'package:flutter/material.dart';
import 'package:lucid_validation/lucid_validation.dart';

class CredentialsWithEmailAndPassword extends ChangeNotifier {
  String email;
  String password;

  CredentialsWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() {
    return {'email': email, 'password': password};
  }

  set newEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  set newPassword(String newPassword) {
    password = newPassword;
    notifyListeners();
  }
}

class CredentialsWithEmailAndPasswordValidator
    extends LucidValidator<CredentialsWithEmailAndPassword> {
  CredentialsWithEmailAndPasswordValidator() {
    ruleFor((credentials) => credentials.email, key: 'email')
        .notEmpty()
        .validEmail()
        .cascade(CascadeMode.stopOnFirstFailure);

    ruleFor((credentials) => credentials.password, key: 'password')
        .notEmpty()
        .cascade(CascadeMode.stopOnFirstFailure);
  }
}
