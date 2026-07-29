import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/gen/assets.gen.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      _navigateToLogin();
    });
  }

  void _navigateToLogin() {
    context.navigate('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Assets.logo.image()));
  }
}
