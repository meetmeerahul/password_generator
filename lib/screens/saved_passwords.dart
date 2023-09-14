import 'package:flutter/material.dart';
import 'package:password_generator/models/dbfunctions/password_manage.dart';
import 'package:password_generator/models/password_model.dart';

class SavedPasswords extends StatelessWidget {
  const SavedPasswords({super.key});

  @override
  Widget build(BuildContext context) {
    getSavedPassowrds();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 177, 169, 193),
        title: const Text(
          "Saved Passwords",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: passwordNotifier,
        builder: (BuildContext ctx, List<PasswordModel> passwordList,
            Widget? child) {
          if (passwordList.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Center(
                child: Text(
                  'No passwords Saved',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
            );
          } else {
            return ListView.separated(
              itemBuilder: (ctx, index) {
                final data = passwordList[index];
                // int bmiVal = int.parse(data.bmi);
                return ListTile(
                  leading: Text(
                    " ${index + 1}.",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  title: Text(
                    data.password,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  trailing: InkWell(
                    onTap: () => deletePassword(index),
                    child: const Icon(Icons.delete),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white,
                  child: const Divider(),
                );
              },
              itemCount: passwordList.length,
            );
          }
        },
      ),
    );
  }
}
