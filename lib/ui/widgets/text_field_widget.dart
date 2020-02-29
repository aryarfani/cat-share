import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController cText;
  final IconData icon;
  final String hintText;
  final String title;

  const TextFieldWidget({this.cText, this.icon, this.hintText, this.title});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: GoogleFonts.openSans(
            color: Colors.black54,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 2.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.black87,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.only(left: 8.0),
              height: 30,
              constraints: BoxConstraints(
                maxWidth:
                    MediaQuery.of(context).size.width - 0.3 * MediaQuery.of(context).size.width,
              ),
              child: TextField(
                style: GoogleFonts.lato(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                controller: cText,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.lato(
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Color(0xFFFF7F56),
          thickness: 0.5,
          height: 0,
        )
      ],
    );
  }
}
