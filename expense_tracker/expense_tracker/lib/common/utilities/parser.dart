
import 'package:flutter/material.dart';

class Parser {
  static Color hexStringToColor(String? hexColor) {
    if(hexColor == null || hexColor.isEmpty) {
      return Colors.white;
    }
    // Add a leading '#' if not present
    if (!hexColor.startsWith('#')) {
      hexColor = '#$hexColor';
    }

    return Color(int.parse(hexColor.substring(1), radix: 16) + 0xFF000000);
  }

  static String colorToHexWithAlpha(Color color) {
    String alpha = color.alpha.toRadixString(16).padLeft(2, '0');
    String red = color.red.toRadixString(16).padLeft(2, '0');
    String green = color.green.toRadixString(16).padLeft(2, '0');
    String blue = color.blue.toRadixString(16).padLeft(2, '0');
    return '#$alpha$red$green$blue'.toUpperCase();
  }
}