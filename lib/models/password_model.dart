import 'package:hive_flutter/hive_flutter.dart';

part 'password_model.g.dart';

@HiveType(typeId: 1)
class PasswordModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String password;

  PasswordModel({required this.password, this.id});
}
