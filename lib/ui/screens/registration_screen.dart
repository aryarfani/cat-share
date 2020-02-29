import 'package:crud_kucing/ui/widgets/ronded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SvgPicture.asset(
                'images/welcome_cat.svg',
                width: 250,
              ),
              SizedBox(height: 10),
              Text(
                'Embark your journey to the cat world',
                style: GoogleFonts.lato(fontSize: 30),
              ),
              Spacer(),
              RoundedButton(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, 'signin');
                },
              ),
              SizedBox(height: 20),
              RoundedButton(
                text: 'Sign In',
                onPressed: () {},
                color: Colors.white,
                textColor: Color(0xFFFF7F56),
              )
            ],
          ),
        ),
      ),
    );
  }
}
