import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerUser extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 200),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Cat\'s gram',
                style: GoogleFonts.lato(),
              ),
            ),
            ListTile(
              trailing: Icon(Icons.help),
              title: Text('Help'),
              subtitle: Text('Are you lost ?'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              trailing: Icon(Icons.lock_open),
              title: Text('Log Out'),
              onTap: () {
                _auth.signOut();
                Navigator.pushReplacementNamed(context, 'registration');
              },
            ),
          ],
        ),
      ),
    );
  }
}
