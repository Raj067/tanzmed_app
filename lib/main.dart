import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/pages/homepage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppSettings.appTitle,
      debugShowCheckedModeBanner: AppSettings.isDebugMode,
      defaultTransition: Transition.downToUp,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppSettings.primaryColor,
      ),
      home: const Homepage(),
    );
  }
}
