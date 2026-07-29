# Testing

Todo teste deve seguir AAA.

- `ARRANGE`: prepara o cenario.
- `ACT`: executa a acao.
- `ASSERT`: valida o resultado.

## Mocks

- Use `mocktail` para mocks.
- Crie uma pasta `mock` por modulo quando o modulo precisar de mocks proprios.
- Prefira mocks proximos do contexto que eles atendem.

## Regras praticas

- Teste o comportamento esperado, nao a implementacao interna.
- Valide contratos de repository, service, command e controller quando fizer sentido.
- Separe arranjo, acao e assertiva com clareza.

## Flutter Modular nos testes

- Use a documentacao oficial do `flutter_modular` para bootstrap de modulos, resolucao de dependencias e testes de rotas.
- Quando o teste envolver DI ou rotas, prefira montar o modulo em vez de simular manualmente a infraestrutura.
- Para UI, o router deve ser montado de forma consistente com o app.

## Checklist

- AAA presente.
- Mocktail usado quando a dependencia e externa ou custosa.
- Nome do teste descreve o comportamento.
- Assertions suficientes para provar o caso.

## Exemplo

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalStorageService extends Mock implements ILocalStorageService {}

void main() {
  late MockLocalStorageService localStorage;
  late BootHasCreatedPasswordService service;

  setUp(() {
    localStorage = MockLocalStorageService();
    service = BootHasCreatedPasswordService(localStorageService: localStorage);
  });

  test('returns false when key is missing', () async {
    // ARRANGE
    when(() => localStorage.containsKey(Constants.masterKeyCredential))
        .thenAnswer((_) async => Success(false));

    // ACT
    final result = await service();

    // ASSERT
    expect(result.isSuccess, true);
    expect(result.getOrThrow().hasCreated, false);
  });
}
```

```dart
test('command changes state when executed', () async {
  // ARRANGE
  final repository = _FakeRepository();
  final command = MasterKeyIsValidCommand(repository: repository);

  // ACT
  await command.execute('123456');

  // ASSERT
  expect(command.state, isA<CommandSuccess<bool?, AppException>>());
});
```
