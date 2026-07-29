import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';

abstract interface class IGetProductsUseCase {
  AsyncResult<AppException, List<Product>> execute(OffersLocation location);
}
