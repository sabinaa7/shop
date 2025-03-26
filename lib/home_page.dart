import 'package:flutter/material.dart';
import 'package:flutter_application_1/second_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage(),
        );
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "lib/assets/photo.png",
                width: double.infinity,
                height: 630,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: 31),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Your', style: TextStyle(fontSize: 20, height: 1)),
                        SizedBox(width: 5),
                        Text(
                          'Personal',
                          style: TextStyle(fontSize: 20, height: 1),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                        'STYLYST',
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 5,
                          height: 0.9,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 43,
            right: 43,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              backgroundColor: Colors.black,
              child: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
