import 'package:flutter/services.dart';
import 'package:windows/constants/app_colors.dart';
import 'package:windows/pages/find_cameras_page.dart';
import 'pages/landing_page.dart';
import 'package:flutter/material.dart';

import 'pages/testing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      title: 'Blue Force',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
