import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/app_module.dart';
import 'package:preco_certo/app/app_widget.dart';

Future<void> main() async {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      runApp(
        ModularApp(
          module: appModule,
          initialRoute: '/login',
          child: const AppWidget(),
        ),
      );
    },
    (error, stackTrace) {
      log("Unexpected Error", error: error, stackTrace: stackTrace);
    },
  );
}
