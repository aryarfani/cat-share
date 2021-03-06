import 'package:crud_kucing/ui/widgets/ronded_button_widget.dart';
import 'package:crud_kucing/ui/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
                    vertical: 20,
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
                        style: GoogleFonts.lato(fontSize: 20),
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
                            'Welcome Back',
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
                        icon: Icons.mail_outline,
                        cText: cEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20),
                      TextFieldWidget(
                        title: 'Password',
                        hintText: 'Insert your password',
                        icon: Icons.vpn_key,
                        cText: cPassword,
                        isPassword: true,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Forgot Password?',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.openSans(
                          color: Color(0xFFFF7F56),
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 20),
                      RoundedButton(
                        text: 'Sign In',
                        onPressed: () async {
                          try {
                            var res = await _auth.signInWithEmailAndPassword(
                                email: cEmail.text, password: cPassword.text);
                            var user = res.user;
                            if (user != null) {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', ModalRoute.withName('home'));
                            }
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
