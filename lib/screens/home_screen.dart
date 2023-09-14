import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/models/dbfunctions/password_manage.dart';
import 'package:password_generator/models/password_model.dart';
import 'package:password_generator/screens/saved_passwords.dart';
import 'package:password_generator/screens/widgets/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Get.to(
                  const SavedPasswords(),
                );
              },
              child: const Icon(Icons.save_as_outlined),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 177, 169, 193),
        title: const Text(
          "Password Generator",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            sizedBox(100),
            TextField(
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
              readOnly: true,
              showCursor: false,
              controller: _passwordController,
              decoration: InputDecoration(
                suffixIcon: InkWell(
                  onTap: () async {
                    if (_passwordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please generate password to copy'),
                        ),
                      );
                    } else {
                      FlutterClipboard.copy(_passwordController.text).then(
                        (value) {
                          return ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password copied to clipboard'),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: const Icon(
                    Icons.copy_sharp,
                  ),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
            ),
            sizedBox(20),
            Obx(
              () => Slider(
                  value: homeController.slidervalue.value.toDouble(),
                  max: 25,
                  divisions: 5,
                  label: homeController.slidervalue.value.toInt().toString(),
                  onChanged: (value) {
                    homeController.slidervalue.value = value;
                  }),
            ),
            sizedBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      onPressed: () {
                        homeController.upper.value =
                            !homeController.upper.value;
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0),
                          backgroundColor: homeController.upper.value
                              ? Colors.teal.shade300
                              : Colors.white),
                      child: const Text('Uppercase'),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      onPressed: () {
                        homeController.lower.value =
                            !homeController.lower.value;
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0),
                          backgroundColor: homeController.lower.value
                              ? Colors.teal.shade300
                              : Colors.white),
                      child: const Text('Lowercase'),
                    ),
                  ),
                ),
              ],
            ),
            sizedBox(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      onPressed: () {
                        homeController.numbers.value =
                            !homeController.numbers.value;
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0),
                          backgroundColor: homeController.numbers.value
                              ? Colors.teal.shade300
                              : Colors.white),
                      child: const Text('Numbers'),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(
                    () => OutlinedButton(
                      onPressed: () {
                        homeController.symbol.value =
                            !homeController.symbol.value;
                      },
                      style: OutlinedButton.styleFrom(
                          side: const BorderSide(width: 1.0),
                          backgroundColor: homeController.symbol.value
                              ? Colors.teal.shade300
                              : Colors.white),
                      child: const Text('Special Characters'),
                    ),
                  ),
                ),
              ],
            ),
            sizedBox(20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      bool caps = homeController.upper.value;
                      bool small = homeController.lower.value;
                      bool num = homeController.numbers.value;
                      bool special = homeController.symbol.value;

                      int len = homeController.slidervalue.value.toInt();

                      String password = generatePassword(
                          caps: caps,
                          num: num,
                          small: small,
                          special: special,
                          len: len);

                      if (homeController.slidervalue.value == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please Increase the length using slider'),
                          ),
                        );
                      } else if (password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select atleast one type'),
                          ),
                        );
                      }
                      _passwordController.text = password;
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.0),
                        backgroundColor:
                            const Color.fromARGB(255, 177, 169, 193)),
                    child: const Text('Generate Password'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _passwordController.text = "";
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.0),
                        backgroundColor:
                            const Color.fromARGB(255, 177, 169, 193)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Icon(Icons.clear), Text('Clear')],
                    ),
                  ),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      if (_passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please generate a password to save'),
                          ),
                        );
                      } else {
                        savePassword(context, _passwordController.text);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1.0),
                        backgroundColor:
                            const Color.fromARGB(255, 177, 169, 193)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Icon(Icons.save), Text('Save')],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  String generatePassword(
      {required bool caps,
      required bool small,
      required bool num,
      required bool special,
      required int len}) {
    String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String lower = "abcdfghijklmnopqrstuvwxyz";
    String numbers = "1234567890";
    String symbol = "!@#%^&*()";

    String password = "";

    String chars = "";

    if (caps) {
      chars += upper;
    }

    if (small) {
      chars += lower;
    }

    if (num) {
      chars += numbers;
    }

    if (special) {
      chars += symbol;
    }

    if (!caps && !small && !num && !special) {
      len = 0;
    }

    List<String> charList = chars.split("").toList();

    Random rand = Random();

    for (int i = 0; i < len; i++) {
      int index = rand.nextInt(charList.length);
      password += charList[index];
    }
    return password;
  }

  Future<void> savePassword(BuildContext context, String password) async {
    final paswordData = PasswordModel(password: password);

    addPassword(paswordData);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password saved'),
      ),
    );
  }
}
