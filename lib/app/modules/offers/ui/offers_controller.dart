import 'package:flutter/foundation.dart';
import 'package:preco_certo/app/modules/offers/models/product.dart';

class OffersController extends ChangeNotifier {
  List<Product> _allProducts = const [];
  String _search = '';
  final Set<String> _selectedProductIds = {};

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
}
