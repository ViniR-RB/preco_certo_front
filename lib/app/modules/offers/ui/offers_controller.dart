import 'package:flutter/foundation.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/modules/offers/data/repositories/i_offers_location_repository.dart';
import 'package:preco_certo/app/modules/offers/models/offers_location.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';

class OffersController extends ChangeNotifier {
  OffersController(this._locationRepository);

  final IOffersLocationRepository _locationRepository;
  List<Product> _allProducts = const [];
  String _search = '';
  final Set<String> _selectedProductIds = {};
  OffersLocation? _location;
  int _radius = 5;
  List<AddressSuggestion> _addressSuggestions = const [];
  bool _isAddressSearchVisible = false;

  OffersLocation? get location => _location;
  List<AddressSuggestion> get addressSuggestions => _addressSuggestions;
  bool get isAddressSearchVisible => _isAddressSearchVisible;

  List<Product> get products {
    final search = _search.trim().toLowerCase();
    if (search.isEmpty) return _allProducts;

    return _allProducts
        .where((product) => product.name.toLowerCase().contains(search))
        .toList(growable: false);
  }

  bool get hasSearch => _search.trim().isNotEmpty;

  bool isSelected(Product product) => _selectedProductIds.contains(product.id);

  void setProducts(List<Product> products) {
    _allProducts = products;
    notifyListeners();
  }

  void setSearch(String value) {
    _search = value;
    notifyListeners();
  }

  void toggleProduct(Product product) {
    if (!_selectedProductIds.add(product.id)) {
      _selectedProductIds.remove(product.id);
    }
    notifyListeners();
  }

  void showAddressSearch() {
    _isAddressSearchVisible = true;
    notifyListeners();
  }

  void hideAddressSearch() {
    _isAddressSearchVisible = false;
    _addressSuggestions = const [];
    notifyListeners();
  }

  AsyncResult<AppException, OffersLocation?> loadLocation() async {
    final result = await _locationRepository.load();
    result.when(
      onSuccess: (location) {
        _location = location;
        notifyListeners();
      },
      onFailure: (_) {},
    );
    return result;
  }

  AsyncResult<AppException, OffersLocation> useDeviceLocation() async {
    final result = await _locationRepository.deviceLocation(radius: _radius);
    result.when(onSuccess: _setLocation, onFailure: (_) {});
    return result;
  }

  Future<Either<AppException, List<AddressSuggestion>>> searchAddress(
    String query,
  ) async {
    final result = await _locationRepository.searchAddress(query);
    result.when(
      onSuccess: (suggestions) {
        _addressSuggestions = suggestions;
        notifyListeners();
      },
      onFailure: (_) {},
    );
    return result;
  }

  AsyncResult<AppException, OffersLocation> selectAddress(
    AddressSuggestion address,
  ) async {
    final result = await _locationRepository.save(
      OffersLocation(
        latitude: address.latitude,
        longitude: address.longitude,
        label: address.label,
        radius: _radius,
      ),
    );
    result.when(onSuccess: _setLocation, onFailure: (_) {});
    return result;
  }

  Future<void> setRadius(int radius) async {
    _radius = radius;
    if (_location == null) {
      notifyListeners();
      return;
    }
    final result = await _locationRepository.save(
      _location!.copyWith(radius: _radius),
    );
    result.when(onSuccess: _setLocation, onFailure: (_) {});
  }

  void _setLocation(OffersLocation location) {
    _location = location;
    _radius = location.radius;
    _isAddressSearchVisible = false;
    _addressSuggestions = const [];
    notifyListeners();
  }
}
