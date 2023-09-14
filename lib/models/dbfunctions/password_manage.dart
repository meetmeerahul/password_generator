import 'package:get/get.dart';
import 'package:password_generator/controllers/home_controller.dart';

import 'package:password_generator/models/password_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

final homeController = Get.put(HomeController());

addPassword(PasswordModel value) async {
  final storedPasswords = await Hive.openBox<PasswordModel>('password_db');
  await storedPasswords.add(value);
  homeController.savedPasswords.add(value);
}

Future<void> getSavedPassowrds() async {
  final passwords = await Hive.openBox<PasswordModel>('password_db');
  final data = passwords.values.toList();
  homeController.savedPasswords.clear();
  for (var i in data) {
    homeController.savedPasswords.add(i);
  }
}

Future<void> deletePassword(int id) async {
  final passwordData = await Hive.openBox<PasswordModel>('password_db');
  passwordData.deleteAt(id);
  getSavedPassowrds();
}
