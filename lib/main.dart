import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:web3_modal_integration/HomePage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web3_modal_integration/core/app_assistant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('prefs');
  await initializeTheAppControllers(); // Initialize controllers
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}

Future<void> initializeTheAppControllers() async {
  Get.put(AppAssistant(), permanent: true);
}
