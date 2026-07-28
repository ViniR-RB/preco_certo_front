import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_products_repository.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';
import 'package:preco_certo/app/modules/offers/usecase/i_get_products_use_case.dart';

class GetProductsService implements IGetProductsUseCase {
  GetProductsService(this._productsRepository);

  final IProductsRepository _productsRepository;

  @override
  AsyncResult<AppException, List<Product>> execute() {
    return _productsRepository.getProducts();
  }
}
