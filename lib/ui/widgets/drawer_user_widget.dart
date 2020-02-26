import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerUser extends StatelessWidget {
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
