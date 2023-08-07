import 'package:flutter/material.dart';
import 'package:ismart/common/constant/fonts.dart';

class CustomTheme {
  //live color
  // static const Color primaryColor = Color(0xFF010C80);
//janadhara primary color
  static Color testAppColor = const Color(0xFF010C80);
  static const Color sahakaryaColor = Color(0xFF015017);
  static const Color manankColor = Color(0xFF015017);
  static const Color janadharaColor = Color(0xFF0b67bb);
  static const Color kabilColor = Color(0xFF0b67bb);
  static const Color abhiyanColor = Color(0xFF015017);
  static const Color kamanaColor = Color(0xFF008133);
  static const Color arthabagColor = Color(0xFF0729a4);
  static const Color alankarColor = Color(0xFF0088cf);
  static const Color gomaganeshColor = Color(0xFF1f972b);
  static const Color shreeAajuColor = Color(0xFF00A900);
  static const Color shreeMitraColor = Color(0xFF00A551);
  static const Color kipooColor = Color(0xFF00A551);
  static const Color suryadevColor = Color(0xFF8E191C);


  static Color primaryColor = shreeAajuColor;


  static const double symmetricHozPadding = 13.0;
  static const Color lightGray = Color(0XFFF3F3F3);
  static const Color gray = Color(0xFFDEDEDE);
  static const Color darkGray = Color(0xFF3E3E3E);
  static const Color lightTextColor = Color(0xff131313);
  static const Color yellow = Color(0xFFFFC107);
  static const Color green = Colors.green;
  static const Color backgroundColor = Color(0xFFECF4FF);
  static const Color googleColor = Color(0xFFDB4437);
  static const Color facebookColor = Color(0xFF4267B2);
  static const Color twitter = Color(0xFF1DA1F2);
  static const Color instagram = Color(0xFFFD1D1D);
  static const Color linkedIn = Color(0xFF2867B2);
  static const Color orangeColor = Color(0xFFEF8767);
  static const Color shadowColor = Color(0x1A000000);
  static const Color darkerBlack = Color(0xff060606);
  static const Color darkTextColor = Color(0xfff8f8f8);
  static const Color white = Colors.white;

  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    shadowColor: Colors.black,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: primaryColor)),
    scaffoldBackgroundColor: backgroundColor,
    iconTheme: const IconThemeData(color: darkerBlack),
    fontFamily: Fonts.poppin,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: lightTextColor, fontWeight: FontWeight.bold, fontSize: 24),
      displayMedium: TextStyle(
          color: lightTextColor, fontWeight: FontWeight.bold, fontSize: 22),
      displaySmall: TextStyle(
          color: lightTextColor, fontWeight: FontWeight.bold, fontSize: 20),
      headlineMedium: TextStyle(fontSize: 18, color: lightTextColor),
      headlineSmall: TextStyle(color: lightTextColor, fontSize: 16),
      titleLarge: TextStyle(
          color: lightTextColor, fontSize: 14, fontWeight: FontWeight.w300),
      bodySmall: TextStyle(color: lightTextColor, fontSize: 8),
      titleSmall: TextStyle(color: lightTextColor, fontSize: 12),
      titleMedium: TextStyle(color: lightTextColor, fontSize: 10),
      labelLarge: TextStyle(color: lightTextColor, fontSize: 12),
      bodyLarge: TextStyle(fontSize: 12, color: lightTextColor),
      bodyMedium: TextStyle(fontSize: 10, color: lightTextColor),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
  );

  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    primaryColorDark: primaryColor,
    shadowColor: Colors.white,
    appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: primaryColor)),
    scaffoldBackgroundColor: darkGray,
    iconTheme: const IconThemeData(color: Colors.white),
    fontFamily: Fonts.poppin,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 24),
      displayMedium: TextStyle(
          color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 22),
      displaySmall: TextStyle(
          color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 20),
      headlineMedium: TextStyle(fontSize: 18, color: darkTextColor),
      headlineSmall: TextStyle(color: darkTextColor, fontSize: 16),
      titleLarge: TextStyle(
          color: darkTextColor, fontSize: 14, fontWeight: FontWeight.w300),
      bodySmall: TextStyle(color: darkTextColor, fontSize: 8),
      titleSmall: TextStyle(color: darkTextColor, fontSize: 12),
      titleMedium: TextStyle(color: darkTextColor, fontSize: 10),
      labelLarge: TextStyle(color: darkTextColor, fontSize: 12),
      bodyLarge: TextStyle(fontSize: 12, color: darkTextColor),
      bodyMedium: TextStyle(fontSize: 10, color: darkTextColor),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: darkGray),
  );
}
