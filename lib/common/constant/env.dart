import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';

class CoOperative {
  CoOperative({
    required this.clientCode,
    required this.clientSecret,
    required this.coOperativeName,
    required this.bannerImage,
    required this.coOperativeLogo,
    required this.baseUrl,
    required this.splashImage,
    required this.primaryColor,
    required this.backgroundImage,
  });

  String baseUrl;
  String clientCode;
  String clientSecret;
  String coOperativeName;
  String bannerImage;
  String coOperativeLogo;
  String splashImage;
  Color primaryColor;
  String backgroundImage;

  CoOperative copyWith({required String clientCode}) {
    return CoOperative(
      clientCode: clientCode,
      clientSecret: clientSecret,
      coOperativeName: coOperativeName,
      bannerImage: bannerImage,
      coOperativeLogo: coOperativeLogo,
      baseUrl: baseUrl,
      splashImage: splashImage,
      primaryColor: primaryColor,
      backgroundImage: backgroundImage,
    );
  }
}

class CoOperativeValue {
  // static final CoOperative chandraGiriCoOperative = CoOperative(
  //   baseUrl: 'http://202.63.242.139:9091/',
  //   bannerImage: 'assets/chandragiri.png',
  //   clientCode: 'CHAN6566',
  //   coOperativeName: 'ChandraGiri CoOperative',
  //   coOperativeLogo: 'assets/chandragiri.png',
  //   clientSecret: "",
  // );

  // DEV
  // static final CoOperative development = CoOperative(
  //   baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'VBMRDWEVFV',
  //   coOperativeName: '',
  //   coOperativeLogo: '',
  //   clientSecret: "199204",
  // );
  // LIVE

//   //******* Janadhara********//
//   static final CoOperative development = CoOperative(
//     baseUrl: 'https://ismart.devanasoft.com.np/', // 9802013689 :97684
//     bannerImage: "assets/janadhara/janadhara_banner.png",
//     clientCode: 'EHVNI7CZJ3', //test
//     clientSecret: "126489", //test

// //    clientCode: '6M0D7LSVNV',
//     //  clientSecret: "180509",

//     coOperativeName: '',
//     coOperativeLogo: 'assets/janadhara/janadhara.png',
//     splashImage: "assets/janadhara_splash.png",
//   );

  // // //******* LIVE ********* //

  // static final CoOperative development = CoOperative(
  //   baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'EHVNI7CZJ3',
  //   coOperativeName: '',
  //   coOperativeLogo: Assets.ismartLogo,
  //   clientSecret: "126489",
  // );

////*****************Abhiyan ***************////
//   static final CoOperative development = CoOperative(
//     baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
//     bannerImage: "assets/uttarganga/uttarganga_banner.png",
//     clientCode: 'VBMRDWEVFV',
//     backgroundImage: "assets/uttarganga/uttarganga_background_image.png",
//     coOperativeName: '',
//     coOperativeLogo: "assets/uttarganga/uttarganga_logo.png",
//     clientSecret: "199204",
//     splashImage: "assets/uttarganga/uttarganga_splash.png",
//     primaryColor: const Color(0xFF2e3192),
//   );

// ////*****************Kamana ***************////
//   static final CoOperative development = CoOperative(
//     baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
//     bannerImage: "assets/uttarganga/uttarganga_banner.png",
//     clientCode: 'LQ7QMJ5NRB',
//     backgroundImage: "assets/uttarganga/uttarganga_background_image.png",
//     coOperativeName: '',
//     coOperativeLogo: "assets/uttarganga/uttarganga_logo.png",
//     clientSecret: "118107",
//     splashImage: "assets/uttarganga/uttarganga_splash.png",
//     primaryColor: const Color(0xFF2e3192),
//   );

////*****************Uttarganga ***************////
  static final CoOperative development = CoOperative(
    baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
    bannerImage: "assets/uttarganga/uttarganga_banner.png",
    clientCode: 'VBMRDWEVFV',
    backgroundImage: "assets/uttarganga/uttarganga_background_image.png",
    coOperativeName: '',
    coOperativeLogo: "assets/uttarganga/uttarganga_logo.png",
    clientSecret: "199204",
    splashImage: "assets/uttarganga/uttarganga_splash.png",
    primaryColor: const Color(0xFF2e3192),
  );

////********************** Sahakarya ***********************//////
  // static final CoOperative shakaryaCoop = CoOperative(
  //   baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
  //   bannerImage: "assets/sahakarya/sahakarya_banner.png",
  //   clientCode: 'SMTZ26RF75',
  //   clientSecret: "194009",
  //   // clientCode: 'VBMRDWEVFV',
  //   // clientSecret: "199204",
  //   backgroundImage: "assets/sahakarya/sahakarya_background_image.png",

  //   coOperativeName: 'Sahakarya',
  //   coOperativeLogo: "assets/sahakarya/sahakarya_logo.png",
  //   splashImage: "assets/sahakarya/sahakarya_splash_image.png",
  //   primaryColor: const Color(0xFF015017),
  // );

  // static final CoOperative janadharaCoop = CoOperative(
  //   baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
  //   bannerImage: "assets/janadhara/janadhara_banner.png",
  //   backgroundImage: "assets/janadhara/janadhara_banner.png",
  //   clientCode: '6M0D7LSVNV',
  //   coOperativeName: 'Janadhara',
  //   coOperativeLogo: 'assets/janadhara/janadhar_logo.png',
  //   clientSecret: "180509",
  //   splashImage: "assets/janadhara/Janadhara-Splash-Resized.png",
  //   primaryColor: const Color(0xFF0b67bb),
  // );
// //  DEV TEST700746
  // static final CoOperative development = CoOperative(
  //   backgroundImage: "assets/images/ismart_background_image.jpg",

  //   baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
  //   bannerImage: "assets/images/ismart_banner.png",

  //   //  bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'EHVNI7CZJ3',
  //   coOperativeName: '',
  //   coOperativeLogo: Assets.ismartLogo,
  //   clientSecret: "126489",
  //   splashImage: "assets/images/ismart_splash.jpg",

  //   primaryColor: const Color(0xFF010C80),
  // );

  // // // DEV TEST70074
  // static final CoOperative development = CoOperative(
  //   baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
  //   bannerImage: "assets/images/ismart_banner.png",
  //   clientCode: 'VBMRDWEVFV',
  //   backgroundImage: "assets/images/ismart_background_image.jpg",
  //   coOperativeName: '',
  //   coOperativeLogo: Assets.ismartLogo,
  //   clientSecret: "199204",
  //   splashImage: "assets/images/ismart_splash.jpg",
  //   primaryColor: const Color(0xFF010C80),
  // );
}
