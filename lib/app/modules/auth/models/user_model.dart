import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:preco_certo/app/modules/auth/models/user_role.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  
  String encode() => jsonEncode(toJson());
}
