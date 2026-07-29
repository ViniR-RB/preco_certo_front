# Layers

O projeto segue uma arquitetura modular.
Cada modulo representa uma fronteira clara entre funcionalidades e agrupa a maior parte das decisoes de negocio, dados e interface relacionadas ao mesmo contexto.

## Objetivo

- Evitar acoplamento entre telas e infraestrutura.
- Manter regras de negocio proximas do modulo que as usa.
- Deixar a UI responsavel por apresentacao e orquestracao de estado.

## Camadas

### Data

- Abstrai e implementa tudo o que vem de fora do dominio da tela.
- Centraliza packages externos, banco, storage, biometria e adaptadores de infraestrutura.
- Pode expor services, repositories, exceptions, dto e models.

### UI

- Representa paginas, components, controller e commands.
- Concentra a interacao com o usuario.
- Usa reatividade via `ChangeNotifier` e `BaseCommand`.

### Supporting core

- Reune tipos comuns, extensions, temas, widgets compartilhados e outras pecas globais.
- Deve ser usado como apoio, nao como lugar para regras de feature.

## Exemplo de fronteira

No modulo `vault`, a estrutura separa claramente:

- `data`: repositories, services, models, dto e exceptions.
- `ui`: paginas, components, controller e commands.
- `core`: tipos, widgets, themes e helpers compartilhados.

## Regra geral

- Se algo fala com o mundo externo, tende a viver em `data`.
- Se algo traduz comportamento para a tela, tende a viver em `ui`.
- Se algo e reutilizavel em varias features, tende a viver em `core`.
