import 'package:crud_kucing/ui/screens/kucing_list_screen.dart';
import 'package:crud_kucing/ui/screens/user_screen.dart';
import 'package:crud_kucing/ui/widgets/drawer_user_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final int insertedIndex;
  HomeScreen({this.insertedIndex});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;

  getCurrentUser() async {
    try {
      loggedUser = await _auth.currentUser();
      print(loggedUser.email);
    } catch (e) {
      print(e);
    }
  }

  static int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    getCurrentUser();
    if (widget.insertedIndex != null) {
      onItemTapped(widget.insertedIndex);
    }
  }

  Future<void> onItemTapped(int index) async {
    //* if button pressed, it will be pushed to addKucing screen and pass back value using BackButtonInterceptor
    if (index == 1) {
      var cek = await Navigator.of(context).pushReplacementNamed('add');
      if (cek != null) {
        print('working interception');
        onItemTapped(0);
      }
    }
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  List<Widget> screenList = [
    KucingList(),
    Container(),
    UserScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerUser(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            title: Text('Add'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightBlueAccent[600],
        onTap: onItemTapped,
      ),
      //* Untuk mencegah screen rebuild ketika diganti
      body: IndexedStack(
        index: _selectedIndex,
        children: screenList,
      ),
    );
  }
}
