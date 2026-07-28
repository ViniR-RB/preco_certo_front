import 'package:flutter/foundation.dart';
import 'package:preco_certo/app/modules/auth/models/user_model.dart';

enum AppSessionStatus { unlogged, logged }

class AppSessionController extends ChangeNotifier {
  AppSessionStatus _status = AppSessionStatus.unlogged;
  UserModel? _user;
  AppSessionStatus get status => _status;
  UserModel? get user => _user;
  bool get isLogged => _status == AppSessionStatus.logged && _user != null;
  void setUser(UserModel user) { _user = user; _status = AppSessionStatus.logged; notifyListeners(); }
  void clear() { _user = null; _status = AppSessionStatus.unlogged; notifyListeners(); }
}
