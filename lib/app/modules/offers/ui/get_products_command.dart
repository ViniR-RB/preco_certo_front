import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/types/states/base_command.dart';
import 'package:preco_certo/app/core/types/states/command_state.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';
import 'package:preco_certo/app/modules/offers/usecase/i_get_products_use_case.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';

class GetProductsCommand extends BaseCommand<List<Product>, AppException> {
  GetProductsCommand(this._getProductsUseCase)
    : super(CommandInitial(const []));

  final IGetProductsUseCase _getProductsUseCase;

  Future<void> execute(OffersLocation location) async {
    setState(CommandLoading());
    final result = await _getProductsUseCase.execute(location);
    result.when(
      onSuccess: (products) => setState(CommandSuccess(products)),
      onFailure: (exception) => setState(CommandFailure(exception)),
    );
  }

  @override
  void reset() => setState(CommandInitial(const []));
}
