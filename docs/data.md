# Data

A camada de `data` e responsavel por abstrair e implementar tudo o que vem de fora do dominio da tela.
Ela e o ponto de contato com packages externos, banco, storage, autenticacao biometrica e qualquer adaptador de infraestrutura.

## Services

- Services representam implementacoes de use cases.
- Use quando existir uma regra mais ampla que precisa separar a logica de UI da logica de negocio.
- O service implementa o contrato definido no mesmo contexto de dominio.

Exemplo do modulo `vault`:

- `BootHasCreatedPasswordUseCase` define o contrato.
- `BootHasCreatedPasswordService` implementa a regra.

Exemplo:

```dart
abstract interface class BootHasCreatedPasswordUseCase {
  AsyncResult<AppException, BootHasCreatedPasswordModel> call();
}

class BootHasCreatedPasswordService implements BootHasCreatedPasswordUseCase {
  final ILocalStorageService _localStorageService;

  BootHasCreatedPasswordService({required ILocalStorageService localStorageService})
      : _localStorageService = localStorageService;

  @override
  AsyncResult<AppException, BootHasCreatedPasswordModel> call() async {
    final result = await _localStorageService.containsKey(
      Constants.masterKeyCredential,
    );

    return result.when(
      onSuccess: (value) => Success(BootHasCreatedPasswordModel(hasCreated: value)),
      onFailure: (exception) {
        if (exception is LocalStorageNotFoundException) {
          return Success(BootHasCreatedPasswordModel(hasCreated: false));
        }
        return Failure(exception);
      },
    );
  }
}
```

## Repositories

Como o projeto usa Drift, cada modulo deve ter um repository responsavel por gerenciar os dados do banco e os modelos daquele modulo.

- O repository centraliza leitura, escrita, verificacao e transformacao dos dados.
- O repository nao deve ser tratado como UI helper.
- O repository pode combinar banco local, storage seguro e transformacoes necessarias para o dominio.

Exemplo do modulo `vault`:

- `IMasterKeyCredentailRepository` define o contrato.
- `MasterKeyCredentialRepository` faz a implementacao.
- O repository guarda a credencial mestra, verifica senha e controla o flag de fingerprint.

Exemplo de fluxo:

```dart
@override
AsyncResult<AppException, bool> verify({required String password}) async {
  final credentialResult = await _readCredential();

  return credentialResult.when(
    onSuccess: (credential) async {
      if (!credential.isValid) {
        return Success(false);
      }

      final salt = base64Decode(credential.salt);
      final secretKey = await _argon2.deriveKeyFromPassword(
        password: password,
        nonce: salt,
      );
      final hashBytes = await secretKey.extractBytes();

      return Success(
        _constantTimeEquals(hashBytes, base64Decode(credential.hash)),
      );
    },
    onFailure: (exception) {
      if (exception is LocalStorageNotFoundException) {
        return Failure(MasterKeyCredentailInvalidException());
      }
      rethrow;
    },
  );
}
```

## Exceptions

A camada de data tambem concentra exceptions.

- Toda exception especifica deve herdar de `AppException`.
- Podem existir exceptions do repository e exceptions dos packages externos.
- Quando a exception nao for conhecida ou for inesperada, use `rethrow` para permitir captura pelo Sentry.

Exemplo:

```dart
class MasterKeyCredentailException extends AppException {
  MasterKeyCredentailException(super.code, [super.message, super.stackTrace]);
}

class MasterKeyCredentailInvalidException extends MasterKeyCredentailException {
  MasterKeyCredentailInvalidException()
      : super(
          'masterKeyCredentialInvalid',
          'Master key credential is invalid',
          StackTrace.current,
        );
}
```

Exemplos:

- `LocalStorageException`
- `BiometricAuthException`
- `MasterKeyCredentailException`

## DTO

DTO existe para trafegar dados entre a camada de ui e a camada de data.

- Use para formularios, payloads e estruturas de entrada e saida que nao sao modelos de banco.
- DTO nao e dominio persistido.

Exemplo:

- `CreateMasterKeyFormDto`

```dart
class CreateMasterKeyFormDto {
  final String password;
  final String confirmPassword;

  const CreateMasterKeyFormDto({
    this.password = '',
    this.confirmPassword = '',
  });
}
```

## Models

Os models representam o dominio do banco quando o modulo precisa lidar com dados provenientes do sqflite/Drift.

- Use models para refletir o formato persistido.
- Use models para mapear o que sai do banco e o que volta para ele.
- Mantenha esses modelos proximos do repository do modulo.

Exemplos do `vault`:

- `MasterKeyCredentialModel`
- `VaultKeysModel`

```dart
class MasterKeyCredentialModel {
  final String salt;
  final String hash;

  const MasterKeyCredentialModel({
    required this.salt,
    required this.hash,
  });

  String toStorage() {
    return jsonEncode({'salt': salt, 'hash': hash});
  }

  factory MasterKeyCredentialModel.fromStorage(String value) {
    final decoded = jsonDecode(value) as Map<String, dynamic>;
    return MasterKeyCredentialModel(
      salt: decoded['salt'] as String? ?? '',
      hash: decoded['hash'] as String? ?? '',
    );
  }
}
```
