import 'package:preco_certo/app/modules/offers/models/offers_location.dart';

abstract final class OffersTestConstants {
  static const location = OffersLocation(
    latitude: -3.7319,
    longitude: -38.5267,
    label: 'Meireles, Fortaleza',
    radius: 5,
  );

  static const locationStorage =
      '{"latitude":-3.7319,"longitude":-38.5267,"label":"Meireles, Fortaleza","radius":5}';
}
