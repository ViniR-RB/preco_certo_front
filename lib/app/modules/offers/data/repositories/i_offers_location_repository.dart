import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';

abstract interface class IOffersLocationRepository {
  AsyncResult<AppException, OffersLocation?> load();
  AsyncResult<AppException, OffersLocation> deviceLocation({
    required int radius,
  });
  AsyncResult<AppException, List<AddressSuggestion>> searchAddress(
    String query,
  );
  AsyncResult<AppException, OffersLocation> save(OffersLocation location);
}
