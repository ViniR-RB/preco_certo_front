import 'package:flutter_test/flutter_test.dart';
import 'package:preco_certo/app/modules/auth/dto/credentials_with_email_and_password.dart';

void main() {
  final validator = CredentialsWithEmailAndPasswordValidator();

  test('accepts credentials with a valid email and password', () {
    // ARRANGE
    final credentials = CredentialsWithEmailAndPassword(
      email: 'user@example.com',
      password: 'password',
    );

    // ACT
    final result = validator.validate(credentials);

    // ASSERT
    expect(result.isValid, isTrue);
  });

  test('reports errors for empty email and password', () {
    // ARRANGE
    final credentials = CredentialsWithEmailAndPassword(email: '', password: '');

    // ACT
    final result = validator.validate(credentials);

    // ASSERT
    expect(result.isValid, isFalse);
    expect(result.firstErrorFor('email'), isNotNull);
    expect(result.firstErrorFor('password'), isNotNull);
  });
}
