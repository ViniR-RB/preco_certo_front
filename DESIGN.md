# Preço Certo — sistema visual

Aplicativo de economia para compras de mercado: direto, leve e confiável.

## Tokens

```css
:root { --bg: oklch(98% .004 250); --surface: oklch(100% 0 0); --fg: oklch(26% .09 252); --muted: oklch(52% .03 252); --border: oklch(89% .02 252); --accent: #0C5AA4; --offer: #FF841C; }
```

## Tipografia

- **Display:** `'Söhne', 'Avenir Next', system-ui, sans-serif` — peso 800; usado em títulos, preços e nomes de seção.
- **Corpo:** `-apple-system, BlinkMacSystemFont, 'SF Pro Text', system-ui, sans-serif` — pesos 400, 600, 700 e 800; usado em campos, botões e textos de apoio.
- **Estilo numérico:** preços em peso 800, com `letter-spacing: -0.05em`; o valor atual sempre prevalece sobre o valor anterior riscado.

| Papel | Família | Peso | Tamanho / entrelinha | Uso |
| --- | --- | ---: | --- | --- |
| Display | Display | 800 | 38px / 0.98 | Título principal mobile |
| Heading | Display | 800 | 20px / 1.15 | Seções e cards |
| Price | Display | 800 | 22px / 1 | Preço de oferta |
| Body | Corpo | 400 | 16px / 1.5 | Descrições e textos de apoio |
| Button | Corpo | 800 | 16px / 1 | Ações primárias e secundárias |
| Label | Corpo | 800 | 13px / 1.2 | Campo de formulário |
| Eyebrow | Corpo | 800 | 12px / 1.2 | Contexto e categoria, caixa alta e espaçamento de 0.1em |

## Botões

| Tipo | Fundo | Texto | Uso | Medidas |
| --- | --- | --- | --- | --- |
| Primário | `#0C5AA4` | Branco | Entrar, criar conta, ver onde comprar, começar | 54px de altura, raio 15px, peso 800 |
| Oferta / adicionar | `#FF841C` | Branco | Adicionar produto à lista | 40 × 40px, raio 12px |
| Textual | Transparente | `#0C5AA4` | Criar cadastro, ações de baixo peso | Mínimo 44px de área de toque |
| Navegação ativa | Transparente | `#0C5AA4` | Item ativo na navegação inferior | Texto 13px, peso 700 |
| Navegação inativa | Transparente | `--muted` | Outros itens da navegação | Texto 13px, peso 700 |

Estados: no toque ou hover, escurecer o fundo em aproximadamente 8%; no foco, usar anel de 3px com `color-mix(in oklch, var(--accent) 15%, transparent)`; estados desabilitados usam `--border` no fundo e `--muted` no texto.

## Postura

1. Fundo claro, bastante espaço e uma ação primária por tela.
2. Azul para ação e navegação; laranja para oferta, economia e adicionar à lista.
3. Raios de 14–18px em campos, cards e botões; borda de 1px discreta.
4. Linguagem simples: “Ver onde comprar”, “Adicionar à lista”, “Economize”.
5. A logo fornecida é usada sem redesenho.
