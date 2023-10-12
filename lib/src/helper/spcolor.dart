import 'package:flutter/material.dart';

class SPColors {
  static Color get main => Color(0xff51d87e);
  static Color get dark => Color.fromARGB(255, 3, 26, 9);
  static Color get light => Color(0xffe1fde9);

  static TextStyle lightStyle(double size,
          {FontWeight? weight, Color? color}) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? light,
      );

  static TextStyle darkStyle(double size, {FontWeight? weight, Color? color}) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? dark,
      );
}
