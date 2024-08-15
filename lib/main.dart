import 'package:flutter/material.dart';
import 'package:tanzmed/helpers/settings.dart';
import 'package:tanzmed/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppSettings.appTitle,
      debugShowCheckedModeBanner: AppSettings.isDebugMode,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: AppSettings.primaryColor,
      ),
      home: const Homepage(),
    );
  }
}
