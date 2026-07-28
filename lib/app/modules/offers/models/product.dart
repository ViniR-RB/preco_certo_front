class Product {
  const Product({
    required this.id,
    required this.barcode,
    required this.name,
    required this.image,
    required this.lowestPrice,
    required this.highestPrice,
  });

  final String id;
  final String barcode;
  final String name;
  final String? image;
  final String lowestPrice;
  final String highestPrice;

  double? get lowestPriceValue => _price(lowestPrice);

  double? get highestPriceValue => _price(highestPrice);

  bool get hasDiscount {
    final lowest = lowestPriceValue;
    final highest = highestPriceValue;
    return lowest != null && highest != null && highest > lowest;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: _string(json['id']),
      barcode: _string(json['barcode']),
      name: _string(json['name']),
      image: _stringOrNull(json['image']),
      lowestPrice: _string(json['lowestPrice']),
      highestPrice: _string(json['highestPrice']),
    );
  }

  static List<Product> listFromResponse(dynamic data) {
    final rawItems = switch (data) {
      List() => data,
      Map() =>
        data['data'] ?? data['products'] ?? data['items'] ?? data['results'],
      _ => null,
    };

    if (rawItems is! List) {
      throw const FormatException('Invalid products response');
    }

    return rawItems
        .whereType<Map>()
        .map((item) => Product.fromJson(Map<String, dynamic>.from(item)))
        .toList(growable: false);
  }

  static String _string(dynamic value) => value?.toString() ?? '';

  static String? _stringOrNull(dynamic value) {
    final text = _string(value).trim();
    return text.isEmpty ? null : text;
  }

  static double? _price(String value) {
    final sanitized = value.replaceAll(RegExp(r'[^0-9,.-]'), '');
    if (sanitized.isEmpty) return null;

    final normalized = sanitized.contains(',')
        ? sanitized.replaceAll('.', '').replaceAll(',', '.')
        : sanitized;
    return double.tryParse(normalized);
  }
}
