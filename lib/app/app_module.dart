import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/core/core_module.dart';
import 'package:preco_certo/app/modules/auth/auth.module.dart';
import 'package:preco_certo/app/modules/offers/offers.module.dart';

final appModule = createModule(
  register: (ModularContext c) {
    c
      ..module(coreModule)
      ..module(authModule)
      ..module(offersModule);
  },
);
