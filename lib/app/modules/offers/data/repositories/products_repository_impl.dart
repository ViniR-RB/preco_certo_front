import 'package:dio/dio.dart';
import 'package:preco_certo/app/core/data/rest_client/rest_client.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_products_repository.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';

class ProductsRepositoryImpl implements IProductsRepository {
  ProductsRepositoryImpl(this._restClient);

  final RestClient _restClient;

  @override
  AsyncResult<AppException, List<Product>> getProducts(
    OffersLocation location,
  ) async {
    try {
      final Response(:data) = await _restClient.auth.get(
        '/api/products',
        queryParameters: {
          'latitude': location.latitude,
          'longitude': location.longitude,
          'radius': location.radius,
        },
      );
      return Success(Product.listFromResponse(data));
    } on DioException {
      rethrow;
    }
  }
}
