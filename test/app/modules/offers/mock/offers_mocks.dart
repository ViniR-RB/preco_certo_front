import 'package:mocktail/mocktail.dart';
import 'package:preco_certo/app/core/data/local_storage/i_local_storage_service.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_offers_location_repository.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';
import 'package:preco_certo/app/modules/offers/usecase/i_get_products_use_case.dart';

class MockLocalStorageService extends Mock implements ILocalStorageService {}

class MockOffersLocationRepository extends Mock
    implements IOffersLocationRepository {}

class MockGetProductsUseCase extends Mock implements IGetProductsUseCase {}

class FakeOffersLocation extends Fake implements OffersLocation {}
