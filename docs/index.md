# Index

Este repositorio segue modularidade: cada modulo e um limite claro entre funcionalidades.
Use este indice como ponto de entrada e carregue apenas o documento necessario para a tarefa.

## Leitura rapida

- [`layers.md`](./layers.md): visao geral da arquitetura por camadas.
- [`data.md`](./data.md): regras da camada de data.
- [`ui.md`](./ui.md): regras da camada de ui.
- [`testing.md`](./testing.md): padroes de teste e mocks.
- [`pagination.md`](./pagination.md): contrato compartilhado de paginacao para repositorios e UI.

## Referencias

- Consulte `DESIGN.md` para tokens visuais, tipografia, superficies e regras de aparencia.
- Consulte os codigos do modulo alterado para detalhes de implementacao.
- Consulte a documentacao oficial do `flutter_modular` quando precisar de detalhes de DI, rotas, state management ou testes.

## Regras base

1. Modulo e fronteira.
2. A camada de data concentra integracoes e adaptacoes de infraestrutura.
3. A camada de ui concentra pagina, componentes, controller e commands.
4. O estado reativo segue `ChangeNotifier`.
5. Erros sao tratados com `Either`, `Success` e `Failure`.
6. Testes seguem AAA: `ARRANGE`, `ACT`, `ASSERT`.
