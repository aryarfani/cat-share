import 'package:crud_kucing/ui/widgets/ronded_button_widget.dart';
import 'package:crud_kucing/ui/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFFE7F3FF), Colors.lightBlue[50]],
                  begin: FractionalOffset(0, 0),
                  end: FractionalOffset(0, 1),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SvgPicture.asset(
                        'images/welcome_cat.svg',
                        width: 220,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Embark your journey to the cat world',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(fontSize: 15),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'New \nAccount',
                            style: GoogleFonts.openSans(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Color(0xFFFF7F56)),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.photo_camera),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      TextFieldWidget(
                        title: 'Email',
                        hintText: 'Insert your email',
                        cText: cEmail,
                        icon: Icons.mail_outline,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      // TextFieldWidget(
                      //   title: 'Username',
                      //   hintText: 'Insert your name',
                      //   icon: Icons.person_outline,
                      // ),
                      // SizedBox(height: 20),
                      TextFieldWidget(
                        title: 'Password',
                        cText: cPassword,
                        hintText: 'Insert your password',
                        icon: Icons.vpn_key,
                        isPassword: true,
                      ),
                      SizedBox(height: 20),
                      RoundedButton(
                        text: 'Sign Up',
                        onPressed: () async {
                          // Navigator.pushReplacementNamed(context, 'home');
                          try {
                            final newUser = await _auth.createUserWithEmailAndPassword(
                                email: cEmail.text, password: cPassword.text);
                            print(newUser.additionalUserInfo);
                          } catch (e) {
                            print(e);
                          }
                        },
                        color: Color(0xFFFF7F56),
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
