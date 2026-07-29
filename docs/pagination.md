# Pagination Contract

`Pagination<T>` is a shared core abstraction for repository-backed list loading in the app.
It belongs in `lib/app/core` because pagination is not specific to `vault`; it is a reusable shape for any feature that needs page-based data loading.

## Location

- DTO: `lib/app/core/types/pagination/page_options.dart`
- Model: `lib/app/core/types/pagination/pagination.dart`
- Order enum: `lib/app/core/types/pagination/pagination_order.dart`

## Contract

`Pagination<T>` should expose:

- `data: T[]`
- `meta`
  - `itemCount: int`
  - `hasNextPage: bool`
  - `hasPreviousPage: bool`
  - `page: int`
  - `take: int`
  - `order: PaginationOrder`

`PaginationOrder` should expose:

- `ASC`
- `DESC`

`PageOptions` should expose:

- `page: int`
- `take: int`
- `order: PaginationOrder`
- `skip`: computed as `(page - 1) * take`
- `initial()`: factory that returns `page = 1`, `take = 10`, and `order = DESC`

## Intended Usage

- Use `Pagination<T>` for repository methods that page local data.
- Use `PageOptions` for paging inputs instead of raw `page` and `take` arguments.
- `PageOptions` carries the request `order` as well as the page size.
- Keep data access in the repository layer.
- Keep page state and loading behavior in UI commands or controllers.
- Do not let widgets talk to Drift or storage directly when a repository can own the query.

## Recommended Flow

1. UI asks a command or controller for the next page.
2. The command builds `PageOptions` and calls the repository with `options` and `order`.
3. The repository returns `Pagination<T>`.
4. The UI renders `data` and uses `meta` to decide whether more data can be requested and to display the total item count.

## Rules

- Default ordering must be explicit.
- Pagination metadata must always be returned with the data.
- `itemCount` must reflect the total number of items available in the data source, not just the current page size.
- `hasNextPage` and `hasPreviousPage` must reflect the actual page state, not guesswork in the UI.
- `PageOptions.skip` is the single source of truth for offset math.
- `PageOptions.initial()` is the shared bootstrap default for first loads.
- `PageOptions.order` and `PaginationMeta.order` must stay aligned.
- Feature modules may consume `Pagination<T>`, but the type itself stays in core.

## Vault Usage

For the vault module, the first boot should load:

- categories
- paginated `vault_keys`

Both should come from repository methods that return shared pagination objects or plain collections when pagination is not needed.
