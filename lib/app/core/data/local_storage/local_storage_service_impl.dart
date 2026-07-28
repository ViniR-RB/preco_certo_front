import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:preco_certo/app/core/config/constants.dart';
import 'package:preco_certo/app/core/config/message_constants.dart';
import 'package:preco_certo/app/core/data/exceptions/local_storage_exception.dart';
import 'package:preco_certo/app/core/data/local_storage/i_local_storage_service.dart';
import 'package:preco_certo/app/core/exceptions/app_exception.dart';
import 'package:preco_certo/app/core/extensions/async_result.dart';
import 'package:preco_certo/app/core/types/either/either.dart';
import 'package:preco_certo/app/core/types/either/unit.dart';

class LocalStorageServiceImpl implements ILocalStorageService {
  final FlutterSecureStorage _storage;

  LocalStorageServiceImpl({required this._storage});

  @override
  AsyncResult<AppException, String> get(String key) async {
    try {
      final value = await _storage.read(key: key);
      if (value == null) {
        return Failure(LocalStorageNotFoundException());
      }
      return Success(value);
    } catch (e, s) {
      log("Error on get local storage", error: e, stackTrace: s);
      throw LocalStorageException(MessageConstants.unknownError, e.toString(), s);
    }
  }

  @override
  AsyncResult<AppException, Unit> set(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);

      return Success(unit);
    } catch (e, s) {
      log("Error on set local storage", error: e, stackTrace: s);
      throw LocalStorageException(MessageConstants.unknownError, e.toString(), s);
    }
  }

  @override
  AsyncResult<AppException, Unit> remove(String key) async {
    try {
      await _storage.delete(key: key);
      return Success(unit);
    } catch (e, s) {
      log("Error on remove local storage", error: e, stackTrace: s);
      throw LocalStorageException("unkownError", e.toString(), s);
    }
  }
}
