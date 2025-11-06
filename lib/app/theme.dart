import 'package:flutter/material.dart';
import 'package:ismart/common/constant/fonts.dart';

class CustomTheme {
  static Color _primaryColor = testAppColor;

  CustomTheme._privateConstructor();
  static final ValueNotifier<Color> primaryColorNotifier =
      ValueNotifier(testAppColor);

  static final CustomTheme _instance = CustomTheme._privateConstructor();
  factory CustomTheme() {
    return _instance;
  }

  static Color get primaryColor => _primaryColor;

  void initializeTheme(Color selectedColor) {
    _primaryColor = selectedColor;
    primaryColorNotifier.value = selectedColor;
  }

  static const Color testAppColor = Color(0xFF010C80);
  static const Color sahakaryaColor = Color(0xFF015017);
  static const Color manankColor = Color(0xFF015017);
  static const Color janadharaColor = Color(0xFF0b67bb);
  static const Color kabilColor = Color(0xFF1f972b);
  static const Color abhiyanColor = Color(0xFF015017);
  static const Color kamanaColor = Color(0xFF008133);
  static const Color arthabagColor = Color(0xFF0729a4);
  static const Color alangkarColor = Color(0xFF0088cf);
  static const Color gomaganeshColor = Color(0xFF1f972b);
  static const Color shreeAajuColor = Color(0xFF00A900);
  static const Color shreeMitraColor = Color(0xFF00A551);
  static const Color shreeNavaprabhatColor = Color(0xFF39B54A);
  static const Color kipooColor = Color(0xFF00A551);
  static const Color suryadevColor = Color(0xFF8E191C);
  static const Color uddhamshilColor = Color(0xFF24B34B);
  static const Color vyasColor = Color(0xFF2B2A6A);
  static const Color newdhaulagiriColor = Color(0xFF662D91);
  static const Color shreejanamukhiColor = Color(0xFF017828);
  static const Color uttargangaColor = Color(0xFF2E3192);
  static const Color ekataColor = Color(0xFF2C2087);
  static const Color bishalSavingColor = Color(0xFF31318E);
  static const Color sardikholaColor = Color(0xFF004B1C);
  static const Color kripaluColor = Color(0xFF009444);
  static const Color sarbahitColor = Color(0xFF26449F);
  static const Color bhanjyangColor = Color(0xFF059445);
  static const Color macchaPuchreColor = Color(0xFF188453);
  static const Color nawajoshColor = Color(0xFF017828);
  static const Color fewaColor = Color(0xFF00984A);
  static const Color sanaKishanColor =
      Color(0xFF009A4E); //Using same color for all sana kishan coop
  static const Color matribhumiColor = Color(0xFF00652E);
  static const Color gandakibesiColor = Color(0xFF006838);
  static const Color batikaColor = Color(0xFF00A651);
  static const Color bhugolColor = Color(0xFF009444);
  static const Color nepalbachatColor = Color(0xFF282D7C);
  static const Color nilgiriColor = Color(0xFF3B4BA0);
  static const Color davisfallColor = Color(0xFF016D3B);
  static const Color sancharColor = Color(0xFF016D3B);
  static const Color hamiSabaiKoKrishiColor = Color(0xFF01812E);
  static const Color rumjatarColor = Color(0xFF118B44);
  static const Color supremeColor = Color(0xFF262262);
  static const Color iconSoftColor = Color(0xFF7EA961);
  static const Color shreeSagarmathaColor = Color(0xFF009B4D);
  static const Color royalGorkhaColor = Color(0xFF006838);
  static const Color buddhaCoopColor = Color(0xFF3D4097);
  static const Color punjaColor = Color(0xFF009444);
  static const Color immanuelColor = Color(0xFF02662C);
  static const Color thankotMahilaColor = Color(0xFF366940);
  static const Color bishnudolColor = Color(0xFF009444);
  static const Color annapurnaColor = Color(0xFF36AD1F);
  static const Color kanchanjunghaColor = Color(0xFF39B54A);
  static const Color janasewaColor = Color(0xFF01A64E);
  static const Color goldenCoopColor = Color(0xFF157A3E);
  static const Color nayanCoopColor = Color(0xFF0A6846);
  static const Color rithepaniCoopColor = Color(0xFF01785C);
  static const Color shreeSubhakamanaColor = Color(0xFF016934);
  static const Color bishalMultiPurposeColor = Color(0xFF08440E);
  static const Color shreeMyagdeColor = Color(0xFF009245);
  static const Color vaidhikColor = Color(0xFF00963F);
  static const Color shreeKalikaColor = Color(0xFF009444);
  static const Color aaratiColor = Color(0xFF1A81CA);
  static const Color shreeHemjaColor = Color(0xFF009245);
  static const Color shubhodayaColor = Color(0xFFF46F2C);
  static const Color garimaAgriColor = Color(0xFF009245);
  static const Color aasthaColor = Color(0xFF2E3487);
  static const Color sunshineColor = Color(0xFF0000FB);
  static const Color chirayuColor = Color(0xFF009245);
  static const Color paschimanchalColor = Color(0xFF2A3585);
  static const Color digitalCoopColor = Color(0xFF0076BC);
  static const Color upakarCoopColor = Color(0xFF009245);
  static const Color uttarbahiniColor = Color(0xFF009245);
  static const Color shubhaSandeshColor = Color(0xFF006837);
  static const Color noorColor = Color(0xFF003F1A);
  static const Color sudarshanColor = Color(0xFF006837);
  static const Color metrangColor = Color(0xFF006837);
  static const Color indreniColor = Color(0xFF2C732E);
  static const Color jharanaColor = Color(0xFF2C732E);
  static const Color avatarColor = Color(0xFF2C732E);
  static const Color chaughadaColor = Color(0xFF04A34F);
  static const Color hetaudaColor = Color(0xFF009245);
  static const Color youthVoiceColor = Color(0xFF009245);
  static const Color pragatishilColor = Color(0xFF0C9044);
  static const Color shitalColor = Color(0xFF009245);
  static const Color darshanColor = Color(0xFF008F01);
  static const Color devshreeColor = Color(0xFF28A914);
  static const Color udhamshilKrishiYantrikColor = Color(0xFF8FC040);
  static const Color smartUdhamshilColor = Color(0xFF09BF3D);
  static const Color shreeDigopanColor = Color(0xFF009225);
  static const Color queenCoopColor = Color(0xFF0072BC);
  static const Color nayakiranColor = Color(0xFF001A5A);
  static const Color kendrabinduColor = Color(0xFF308188);
  static const Color eastwestColor = Color(0xFF006311);
  static const Color babiraColor = Color(0xFF25428E);
  static const Color ektaMultipurposeColor = Color(0xFF0C8387);
  static const Color sarbahitDangColor = Color(0xFF009245);
  static const Color shwetBhairabColor = Color(0xFF1B1464);
  static const Color shreeEkataColor = Color(0xFF009444);
  static const Color karmathColor = Color(0xFF008131);
  static const Color shreeSiddhiGaneshColor = Color(0xFF188649);
  static const Color shreeJanaekikritColor = Color(0xFF3D6028);
  static const Color mithilaColor = Color(0xFF009245);
  static const Color shreeMahilaTarkariColor = Color(0xFF009245);
  static const Color shreeMitereeColor = Color(0xFF00964F);
  static const Color janataColor = Color(0xFF00803E);
  static const Color agrasarColor = Color(0xFF0C7E40);
  static const Color khotangJaleshworiColor = Color(0xFF005AAB);
  static const Color puspanjaliColor = Color(0xFF009C4F);
  static const Color starlightColor = Color(0xFF01A54E);
  static const Color shreeAmrapaliColor = Color(0xFF004382);
  static const Color autobikashColor = Color(0xFF0071BC);
  static const Color aakashbaniColor = Color(0xFF00A650);
  static const Color tanahuKalikaColor = Color(0xFF26CF02);
  static const Color shreeMarsyangdiColor = Color(0xFF006837);
  static const Color abhibadanColor = Color(0xFF009245);
  static const Color khullabazarColor = Color(0xFF009245);
  static const Color chandaniColor = Color(0xFF006837);
  static const Color lifeVisionColor = Color(0xFF0066B2);
  static const Color sparklingColor = Color(0xFF2B4C8F);
  static const Color pacificColor = Color(0xFF004382);
  static const Color samutthanColor = Color(0xFF00713B);
  static const Color hamroDahachokColor = Color(0xFF009245);
  static const Color globalMultiColor = Color(0xFF1A9640);
  static const Color dhanapraptiColor = Color(0xFF1B1464);
  static const Color shreeNawadeepColor = Color(0xFF00A95A);
  static const Color belchautaraColor = Color(0xFF3F4070);
  static const Color subhashreeMultiColor = Color(0xFF0087BC);
  static const Color shubhaShreeColor = Color(0xFF3524BE);
  static const Color yugbaniColor = Color(0xFF1F9400);
  static const Color bouddhamodeColor = Color(0xFF09730E);
  static const Color mangalpurColor = Color(0xFF018D46);
  static const Color shreeGaneshColor = Color(0xFF006837);
  static const Color graminAarthikColor = Color(0xFF066735);
  static const Color samyuktaColor = Color(0xFF0DB14B);
  static const Color shreeJamuneColor = Color(0xFF312783);
  static const Color drabyaColor = Color(0xFF009F4D);
  static const Color omshreeomColor = Color(0xFF1B1464);
  static const Color upayogiColor = Color(0xFF2E3192);
  static const Color sakarColor = Color(0xFF04A44C);

  // static const Color primaryColor = aasthaColor;

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
  static const Color spanishGray = Color(0xFF9D9D9D);

  static const Color white = Colors.white;

  static ThemeData get lightTheme => ThemeData(
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
        // bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
      );

  static ThemeData get darkTheme => ThemeData(
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
        // bottomAppBarTheme: const BottomAppBarTheme(color: darkGray),
      );
}
