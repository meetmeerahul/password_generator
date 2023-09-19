import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_generator/models/password_model.dart';
import 'package:password_generator/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:password_generator/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(PasswordModelAdapter().typeId)) {
    Hive.registerAdapter(PasswordModelAdapter());
  }

  await Hive.openBox<PasswordModel>('password_db');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
