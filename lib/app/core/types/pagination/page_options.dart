
import 'package:preco_certo/app/core/types/pagination/pagination_order.dart';

class PageOptions {
  final int page;
  final int take;
  final PaginationOrder order;

  const PageOptions({
    required this.page,
    required this.take,
    required this.order,
  });

  factory PageOptions.initial({
    PaginationOrder order = PaginationOrder.desc,
  }) {
    return PageOptions(
      page: 1,
      take: 10,
      order: order,
    );
  }

  int get skip => (page - 1) * take;
}
