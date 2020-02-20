import 'package:crud_kucing/ui/screens/add_screen.dart';
import 'package:crud_kucing/ui/screens/kucing_list_screen.dart';
import 'package:crud_kucing/ui/screens/user_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int insertedIndex;
  HomePage({this.insertedIndex});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    if (widget.insertedIndex != null) {
      onItemTapped(widget.insertedIndex);
    }
  }

  Future<void> onItemTapped(int index) async {
    //* Add button pushed will be pushed to addKucing screen and pass back value using BackButtonInterceptor
    if (index == 1) {
      var cek = await Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return AddKucing();
      }));
      if (cek != null) {
        print('working interception');
        onItemTapped(0);
        print('yup');
      }
    }
    if (mounted) {
      setState(() {
        _selectedIndex = index;
        print(_selectedIndex);
      });
    }
  }

  List<Widget> screenList = [
    KucingList(),
    Container(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
