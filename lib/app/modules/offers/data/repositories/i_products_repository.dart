import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';

abstract interface class IProductsRepository {
  AsyncResult<AppException, List<Product>> getProducts();
}
