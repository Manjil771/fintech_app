import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mp;
import 'package:flutter/services.dart';

enum TextSizeType { Width, Height }

class TextUtils {
  static Map<String, String> splitName(String fullname) {
    final _temp = fullname.split(" ");
    String fname = "";
    String lname = "";

    if (_temp.length > 1) {
      fname = _temp.first;
      lname = _temp.sublist(1).join(" ");
    } else {
      fname = _temp.first;
    }

    return {
      'firstname': fname,
      'lastname': lname,
    };
  }

  static bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static double getRequiredTextSize({
    required String mytext,
    required TextStyle style,
    required double maxWidth,
    TextAlign textAlign = TextAlign.left,
    required BuildContext context,
    TextSizeType sizeType = TextSizeType.Height,
  }) {
    final textScaleFactor = MediaQuery.textScaleFactorOf(context);
    final textHeightBehaviour = DefaultTextStyle.of(context).textHeightBehavior;
    const textWidthBasis = TextWidthBasis.parent;
    final span = TextSpan(
      text: mytext,
      style: style,
    );
    final tp = TextPainter(
      textAlign: textAlign,
      text: span,
      textDirection: mp.TextDirection.ltr,
      textScaleFactor: textScaleFactor,
      textHeightBehavior: textHeightBehaviour,
      textWidthBasis: textWidthBasis,
    );
    tp.layout(maxWidth: maxWidth);
    if (sizeType == TextSizeType.Height) {
      return tp.size.height;
    } else {
      return tp.size.width;
    }
  }

  static List<TextInputFormatter> get textOnlyFormater =>
      [FilteringTextInputFormatter(RegExp(r'[a-zA-Z ]'), allow: true)];

  static List<TextInputFormatter> get numberOnlyFormater =>
      [FilteringTextInputFormatter.digitsOnly];

  static List<TextInputFormatter> get decimalInputFormater =>
      [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))];

  static String filterSpecialCharacterExceptPlus(String val) {
    return val
        .replaceAll(RegExp('[^+0-9]'), "")
        .trim()
        .replaceAll("+977", "")
        .replaceAll("977", "")
        .trim();
  }
}

extension Capitalize on String {
  String capitalize({bool allWords = true}) {
    if (isEmpty) {
      return this;
    }
    if (allWords) {
      final List<String> words = split(' ');
      final List<String> capitalized = <String>[];
      for (var w in words) {
        capitalized.add(w.capitalize(allWords: false));
      }
      return capitalized.join(' ');
    } else {
      return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
    }
  }

  String nameShortcut() {
    final List<String> _items =
        split(" ").map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    if (_items.isEmpty) {
      return "";
    } else if (_items.length == 1) {
      return _items[0];
    } else {
      return "${_items.first[0]}${_items.last[0]}";
    }
  }
}
