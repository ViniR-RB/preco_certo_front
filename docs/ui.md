# UI

A camada de `ui` e formada por paginas e pelos elementos que compoem cada pagina.

## Paginas e components

- Cada pagina representa uma tela ou fluxo.
- Cada pagina pode ser quebrada em components menores.
- Components formam a pagina maior e devem ser reutilizaveis quando fizer sentido.

## Controller

O controller e o ViewModel da pagina.

- O controller segue o padrao de `ChangeNotifier`.
- Ele entrega reatividade sem depender de value state.
- Ele representa um estado mais geral, mas ainda pode ser observado como value state quando necessario.

Exemplo:

- `LoginController`

```dart
class LoginController extends ChangeNotifier {
  bool _showPassword = false;

  bool get showPassword => _showPassword;

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
    notifyListeners();
  }
}

class LoginActions extends StatelessWidget {
  const LoginActions({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<LoginController>();

    return IconButton(
      onPressed: context.read<LoginController>().togglePasswordVisibility,
      icon: Icon(controller.showPassword ? Icons.visibility_off : Icons.visibility),
    );
  }
}
```

## Commands

Commands encapsulam regras de negocio.

- Eles fazem a traducao da logica de dominio para a logica de UI.
- Eles usam `BaseCommand`, que e um state pattern com `ChangeNotifier`.
- Consulte os commands existentes do modulo para seguir o mesmo formato antes de criar um novo.

Padrao esperado:

- `CommandInitial`
- `CommandLoading`
- `CommandSuccess`
- `CommandFailure`

Exemplos:

- `MasterKeyIsValidCommand`
- `FingerprintAuthenticateCommand`

Exemplo:

```dart
class MasterKeyIsValidCommand extends BaseCommand<bool?, AppException> {
  final IMasterKeyCredentailRepository _repository;

  MasterKeyIsValidCommand({required IMasterKeyCredentailRepository repository})
      : _repository = repository,
        super(CommandInitial(null));

  Future<void> execute(String password) async {
    setState(CommandLoading());

    final result = await _repository.verify(password: password);

    result.when(
      onSuccess: (data) {
        setState(CommandSuccess(data));
      },
      onFailure: (exception) {
        setState(CommandFailure(exception));
      },
    );
  }

  @override
  void reset() {
    setState(CommandInitial(null));
  }
}
```

## Fluxo de erro

As regras de negocio e as chamadas assincronas devem retornar `Either`.

- `Success` representa sucesso.
- `Failure` representa erro.
- Use `when` para ramificar o resultado.
- Use `flatMap` quando precisar encadear resultados assincronas.
- `Unit` representa `void`.
- `Nil` representa `null`.

Regras praticas:

- Trate somente erros esperados e conforme a necessidade do negocio.
- Erros conhecidos devem ser transformados em `Failure`.
- Erros desconhecidos devem ser relancados com `rethrow`.
- O tratamento final de erro fica centralizado na UI e nas translators.
- Na camada de `ui`, nao use `try/catch` para fluxo normal de erro; consuma o resultado pelos metodos de `Either` (`when`, `flatMap`, etc.).

Exemplo de encadeamento:

```dart
Future<AsyncResult<AppException, bool>> canOpenVault(
  BootHasCreatedPasswordUseCase bootUseCase,
  IMasterKeyCredentailRepository repository,
) async {
  return bootUseCase().flatMap((boot) {
    if (!boot.hasCreated) {
      return Future.value(Success(false));
    }

    return repository.hasCredential();
  });
}
```

## Helpers de tela

Nas paginas, use os helpers do projeto para reduzir codigo repetido:

- `loader_message`
- `message_translator`
- `success_translator`
- `error_translator`

Esses helpers permitem inserir loading, snackbar e traducoes sem espalhar a logica manualmente pela pagina.

## Textos com L10n

- Todo texto de UI que vem de `l10n` deve ter uma constante correspondente em `MessageConstants`.
- Use `MessageConstants` como fonte unica para chaves de textos traduzidos.
- Se um texto hardcode precisar de traducao, adicione primeiro a constante em `MessageConstants` e depois inclua o mapeamento no translator adequado.
- Mensagens de erro, sucesso e textos normais devem ser consumidos pelos translators do projeto, nao diretamente por `AppLocalizations.of(context)`.

## Theme e atoms

O `app_theme` ja expoe extensions de texto e cores.
Consulte `DESIGN.md` quando precisar validar tokens visuais, contraste ou a direcao estetica do projeto.

Os atoms da aplicacao ficam em `core/widgets`.

- Use atoms para componentes globais e compartilhados.
- Evite duplicar widgets de uso recorrente em paginas isoladas.

Exemplos:

- `AppBrandAppBar`
- `AppLogo`
- `AppLogoIcon`
- `AppSnackBar`

```dart
Widget build(BuildContext context) {
  final controller = context.watch<LoginController>();
  final command = context.watch<MasterKeyIsValidCommand>();

  return Column(
    children: [
      TextField(
        obscureText: !controller.showPassword,
        onChanged: context.read<LoginController>().togglePasswordVisibility,
      ),
      switch (command.state) {
        CommandInitial() => const SizedBox.shrink(),
        CommandLoading() => const CircularProgressIndicator(),
        CommandSuccess() => const Icon(Icons.check),
        CommandFailure(:final exception) => Text(exception.message ?? 'Error'),
      },
    ],
  );
}
```

## Modular na UI

- `provide` registra state escopado por pagina.
- `route` descreve a navegacao da feature.
- `context.read<T>()` e `context.watch<T>()` devem ser usados conforme a necessidade de reatividade.
- Use `createModule` como unidade principal de composicao de rotas e dependencias da feature.
