import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'value')
enum UserRole {
  user("USER"),
  admin("ADMIN");

  const UserRole(this.value);
  final String value;
}
