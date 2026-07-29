import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:preco_certo/app/core/config/constants.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/data/exceptions/local_storage_exception.dart';
import 'package:preco_certo/app/core/data/local_storage/i_local_storage_service.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/modules/offers/data/exceptions/offers_location_exception.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_offers_location_repository.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';

class OffersLocationRepositoryImpl implements IOffersLocationRepository {
  OffersLocationRepositoryImpl(this._storage);

  final ILocalStorageService _storage;

  @override
  AsyncResult<AppException, OffersLocation?> load() async {
    final result = await _storage.get(Constants.offersLocation);
    return result.when(
      onSuccess: (value) => Success(OffersLocation.fromStorage(value)),
      onFailure: (exception) {
        if (exception is LocalStorageNotFoundException) return Success(null);
        return Failure(exception);
      },
    );
  }

  @override
  AsyncResult<AppException, OffersLocation> deviceLocation({
    required int radius,
  }) async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        return Failure(
          OffersLocationException(
            MessageConstants.offersDeviceLocationUnavailable,
          ),
        );
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return Failure(
          OffersLocationException(MessageConstants.offersDeviceLocationDenied),
        );
      }

      final position = await Geolocator.getCurrentPosition().timeout(
        const Duration(seconds: 10),
      );
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks.isEmpty ? null : placemarks.first;
      final label = _placemarkLabel(place) ?? 'Sua localização';
      return save(
        OffersLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          label: label,
          radius: radius,
        ),
      );
    } on LocationServiceDisabledException {
      return Failure(
        OffersLocationException(
          MessageConstants.offersDeviceLocationUnavailable,
        ),
      );
    } on PermissionDeniedException {
      return Failure(
        OffersLocationException(MessageConstants.offersDeviceLocationDenied),
      );
    } on TimeoutException {
      return Failure(
        OffersLocationException(
          MessageConstants.offersDeviceLocationUnavailable,
        ),
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  AsyncResult<AppException, List<AddressSuggestion>> searchAddress(
    String query,
  ) async {
    try {
      final locations = await locationFromAddress(query);
      if (locations.isEmpty) {
        return Failure(
          OffersLocationException(MessageConstants.offersAddressNotFound),
        );
      }
      final suggestions = <AddressSuggestion>[];
      for (final location in locations.take(5)) {
        final placemarks = await placemarkFromCoordinates(
          location.latitude,
          location.longitude,
        );
        suggestions.add(
          AddressSuggestion(
            latitude: location.latitude,
            longitude: location.longitude,
            label:
                _placemarkLabel(placemarks.isEmpty ? null : placemarks.first) ??
                query,
          ),
        );
      }
      return Success(suggestions);
    } on NoResultFoundException {
      return Failure(
        OffersLocationException(MessageConstants.offersAddressNotFound),
      );
    } catch (_) {
      rethrow;
    }
  }

  @override
  AsyncResult<AppException, OffersLocation> save(
    OffersLocation location,
  ) async {
    final result = await _storage.set(
      Constants.offersLocation,
      location.toStorage(),
    );
    return result.when(
      onSuccess: (_) => Success(location),
      onFailure: Failure.new,
    );
  }

  String? _placemarkLabel(Placemark? place) {
    if (place == null) return null;
    final values = [
      place.street,
      place.subLocality,
      place.locality,
    ].whereType<String>().where((value) => value.trim().isNotEmpty).toList();
    return values.isEmpty ? null : values.join(', ');
  }
}
