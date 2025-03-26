import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(490, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }
}