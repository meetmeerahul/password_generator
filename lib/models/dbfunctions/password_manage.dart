import 'package:flutter/material.dart';
import 'package:password_generator/models/password_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<PasswordModel>> passwordNotifier = ValueNotifier([]);

addPassword(PasswordModel value) async {
  final storedPasswords = await Hive.openBox<PasswordModel>('password_db');
  await storedPasswords.add(value);
  passwordNotifier.value.add(value);
}

Future<void> getSavedPassowrds() async {
  final passwords = await Hive.openBox<PasswordModel>('password_db');
  final data = passwords.values.toList();
  passwordNotifier.value.clear();
  for (var i in data) {
    passwordNotifier.value.add(i);
  }
}

Future<void> deletePassword(int id) async {
  final passwordData = await Hive.openBox<PasswordModel>('password_db');
  passwordData.deleteAt(id);
  getSavedPassowrds();
}
