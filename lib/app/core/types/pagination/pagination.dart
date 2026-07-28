
import 'package:preco_certo/app/core/types/pagination/pagination_order.dart';

class PaginationMeta {
  final int itemCount;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final int page;
  final int take;
  final PaginationOrder order;

  const PaginationMeta({
    required this.itemCount,
    required this.hasNextPage,
    required this.hasPreviousPage,
    required this.page,
    required this.take,
    required this.order,
  });
}

class Pagination<T> {
  final List<T> data;
  final PaginationMeta meta;

  const Pagination({
    required this.data,
    required this.meta,
  });



  Pagination<T> merge(Pagination<T> other) {
    final mergedData = [...data, ...other.data];
    final mergedMeta = PaginationMeta(
      itemCount: other.meta.itemCount,
      hasNextPage: other.meta.hasNextPage,
      hasPreviousPage: other.meta.hasPreviousPage,
      page: other.meta.page,
      take: other.meta.take,
      order: other.meta.order,
    );

    return Pagination<T>(
      data: mergedData,
      meta: mergedMeta,
    );
  }
}
