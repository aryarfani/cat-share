import 'package:crud_kucing/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Kucing',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
