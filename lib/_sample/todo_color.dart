import 'package:flutter/material.dart';

class TodoColor {
  static List<Color> setColors() => [
        Colors.red,
        Colors.amber,
        Colors.purpleAccent,
        Colors.lightBlue,
        Colors.blue,
        Colors.deepOrange,
        Colors.pink,
        Colors.teal,
        Colors.indigoAccent,
        Colors.green,
      ];
  static Color colorOf(int index) => switch (index) {
        0 => Colors.red,
        1 => Colors.amber,
        2 => Colors.purpleAccent,
        3 => Colors.lightBlue,
        4 => Colors.blue,
        5 => Colors.deepOrange,
        6 => Colors.pink,
        7 => Colors.teal,
        8 => Colors.indigoAccent,
        9 => Colors.green,
        _ => const Color.fromRGBO(91, 91, 91, 1),
      };
}
