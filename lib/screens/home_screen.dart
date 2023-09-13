import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/controllers/home_controller.dart';
import 'package:password_generator/screens/widgets/constants.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.save_as_outlined),
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
                  max: 20,
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
                      int val = 1125 * homeController.slidervalue.value.toInt();

                      _passwordController.text = val.toString();
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
                    onPressed: () {},
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
}
