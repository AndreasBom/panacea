import 'package:flutter/material.dart';

class Navigate {
  static void replace(BuildContext context, Widget widget) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> widget), (Route<dynamic> route) => false);
  }

  static void to(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_)=> widget));
  }

  static void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
