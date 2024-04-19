import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AppNavigation {
  static to(BuildContext context, Widget child) {
    Navigator.push(
        context, PageTransition(type: PageTransitionType.fade, child: child));
  }

  static toReplace(BuildContext context, Widget child) {
    Navigator.pushReplacement(
        context, PageTransition(type: PageTransitionType.fade, child: child));
  }

  static toReplaceAll(BuildContext context, Widget child) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => child),
      (route) => false,
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
