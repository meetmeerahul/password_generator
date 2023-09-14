import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/models/dbfunctions/password_manage.dart';

class SavedPasswords extends StatelessWidget {
  const SavedPasswords({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 177, 169, 193),
        title: const Text(
          "Saved Passwords",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(() {
        return homeController.savedPasswords.length.isGreaterThan(0)
            ? ListView.builder(
                itemCount: homeController.savedPasswords.length,
                itemBuilder: (context, index) {
                  final password = homeController.savedPasswords[index];
                  return ListTile(
                    leading: Text(
                      "${index + 1}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    title: Text(
                      password.password,
                      style: const TextStyle(
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: InkWell(
                      onTap: () => deletePassword(index),
                      child: const Icon(Icons.delete_forever),
                    ),
                  );
                })
            : const Center(
                child: Text(
                  "No Saved Passwords",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              );
      }),
    );
  }
}
