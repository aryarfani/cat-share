import 'package:crud_kucing/ui/screens/add_screen.dart';
import 'package:crud_kucing/ui/screens/detail_screen.dart';
import 'package:crud_kucing/ui/screens/edit_screen.dart';
import 'package:crud_kucing/ui/screens/home_screen.dart';
import 'package:crud_kucing/ui/screens/registration_screen.dart';
import 'package:crud_kucing/ui/screens/splash_screen.dart';
import 'package:crud_kucing/ui/screens/user_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD Kucing',
      initialRoute: 'home',
      debugShowCheckedModeBanner: false,
      routes: {
        'splash': (context) => SplashScreen(),
        'home': (context) => HomeScreen(),
        'add': (context) => AddScreen(),
        'detail': (context) => DetailScreen(),
        'edit': (context) => EditScreen(),
        'registration': (context) => RegistrationScreen(),
        'user': (context) => UserScreen(),
      },
    );
  }
}
