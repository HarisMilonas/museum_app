import 'dart:ui';

import 'package:flutter/material.dart';

class CustomColors {
  static const Color lettersColor = Color.fromARGB(255, 67, 67, 9);
}

class CustomSizes {
 static double maxWidth(BuildContext context) =>
      MediaQuery.of(context).size.width -
      MediaQuery.of(context).padding.horizontal;

 static double maxHeight(BuildContext context) =>
      MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.vertical;

  static double halfWidth(BuildContext context) =>
      (MediaQuery.of(context).size.height / 2) -
      MediaQuery.of(context).padding.vertical;

  static double halfHeight(BuildContext context) =>
      (MediaQuery.of(context).size.height / 2) -
      MediaQuery.of(context).padding.vertical;    

}
