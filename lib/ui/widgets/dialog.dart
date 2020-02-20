import 'package:flutter/material.dart';

void showAlertDialog(BuildContext context, Function deleteCallback) {
  // set up the buttons
  Widget noButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget yesButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      deleteCallback();
      // menutup dialog
      Navigator.of(context).pop();
      // menutup screen dan mengembalikan true
      Navigator.pop(context, true);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Delete Post"),
    content: Text("Do you really want to delete this post ?"),
    actions: [
      noButton,
      yesButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
