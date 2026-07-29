import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:preco_certo/app/core/config/constants.dart';
import 'package:preco_certo/app/core/data/exceptions/local_storage_exception.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/offers_location_repository_impl.dart';

import '../../constants/offers_test_constants.dart';
import '../../mock/offers_mocks.dart';

void main() {
  late MockLocalStorageService storage;
  late OffersLocationRepositoryImpl repository;

  setUp(() {
    storage = MockLocalStorageService();
    repository = OffersLocationRepositoryImpl(storage);
  });

  test('loads the saved offers location', () async {
    // ARRANGE
    when(
      () => storage.get(Constants.offersLocation),
    ).thenAnswer((_) async => Success(OffersTestConstants.locationStorage));

    // ACT
    final result = await repository.load();

    // ASSERT
    expect(result.isSuccess, isTrue);
    expect(
      result.getOrThrow()!.toJson(),
      OffersTestConstants.location.toJson(),
    );
    verify(() => storage.get(Constants.offersLocation)).called(1);
  });

  test('returns no location when there is no saved value', () async {
    // ARRANGE
    when(
      () => storage.get(Constants.offersLocation),
    ).thenAnswer((_) async => Failure(LocalStorageNotFoundException()));

    // ACT
    final result = await repository.load();

    // ASSERT
    expect(result.isSuccess, isTrue);
    expect(result.getOrThrow(), isNull);
  });

  test('saves the selected offers location', () async {
    // ARRANGE
    when(
      () => storage.set(
        Constants.offersLocation,
        OffersTestConstants.locationStorage,
      ),
    ).thenAnswer((_) async => Success(unit));

    // ACT
    final result = await repository.save(OffersTestConstants.location);

    // ASSERT
    expect(result.getOrThrow().toJson(), OffersTestConstants.location.toJson());
    verify(
      () => storage.set(
        Constants.offersLocation,
        OffersTestConstants.locationStorage,
      ),
    ).called(1);
  });
}
