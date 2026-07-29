import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:preco_certo/app/core/widgets/app_loading_widget.dart';
import 'package:preco_certo/app/core/widgets/app_snack_bar.dart';

class LoaderMessageNotifier extends ChangeNotifier {
  bool _isLoading = false;
  String? _message;
  SnackType? _type;
  // ignore: prefer_final_fields
  bool _isDisposed = false;

  bool get isLoading => _isLoading;
  String? get message => _message;
  SnackType? get type => _type;

  void showLoader() {
    _isLoading = true;
    _safeNotify();
  }

  void hideLoader() {
    _isLoading = false;
    _safeNotify();
  }

  void showMessage(String message, SnackType type) {
    _message = message;
    _type = type;
    _safeNotify();

    Future.microtask(() {
      _message = null;
      _type = null;
    });
  }

  void _safeNotify() {
    if (!_isDisposed) notifyListeners();
  }
}

mixin LoaderMessageMixin<T extends StatefulWidget> on State<T> {
  late final LoaderMessageNotifier notifier;
  bool _isDialogOpen = false;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    notifier = LoaderMessageNotifier();
    notifier.addListener(_handleNotifier);
  }

  void _handleNotifier() {
    if (!mounted) return;

    // Loader
    if (notifier.isLoading && !_isDialogOpen) {
      _isDialogOpen = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || !notifier.isLoading || !_isDialogOpen) {
          _isDialogOpen = false;
          return;
        }

        _isDialogShown = true;
        showDialog(
          context: context,
          builder: (_) => AppLoadingWidget(),
          barrierDismissible: false,
        ).whenComplete(() {
          _isDialogOpen = false;
          _isDialogShown = false;
        });
      });
    } else if (!notifier.isLoading && _isDialogOpen) {
      _isDialogOpen = false;
      if (_isDialogShown) context.pop();
    }

    if (notifier.message != null && notifier.type != null) {
      switch (notifier.type!) {
        case SnackType.error:
          AppSnackBar.show(
            context,
            message: notifier.message!,
            type: SnackType.error,
          );
          break;
        case SnackType.success:
          AppSnackBar.show(
            context,
            message: notifier.message!,
            type: SnackType.success,
          );
          break;
        case SnackType.info:
          AppSnackBar.show(
            context,
            message: notifier.message!,
            type: SnackType.info,
          );
          break;
      }
    }
  }

  @override
  void dispose() {
    notifier.removeListener(_handleNotifier);
    notifier.dispose();
    super.dispose();
  }
}
