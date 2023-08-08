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
    required this.appStoreID,
    required this.packageName,
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
  String appStoreID;
  String packageName;

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
      appStoreID: appStoreID,
      packageName: packageName,
    );
  }
}

class CoOperativeValue {
  static final CoOperative kabilCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/kabil/kabil_banner.png",
    clientCode: 'AA9ZZ33R9Z',
    clientSecret: "135639",
    // clientCode: 'VBMRDWEVFV',
    // clientSecret: "199204",
    backgroundImage: "assets/kabil/kabil_background_image.png",

    coOperativeName: 'Abhiyan',
    coOperativeLogo: "assets/kabil/kabil_logo.png",
    splashImage: "assets/kabil/kabil_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.kabil",
    appStoreID: "",
  );

  static final CoOperative abhiyanCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/abhiyan/abhiyan_banner.png",
    clientCode: 'L7CLJMN51D',
    clientSecret: "192939",
    backgroundImage: "assets/abhiyan/abhiyan_background_image.png",
    coOperativeName: 'Abhiyan',
    coOperativeLogo: "assets/abhiyan/abhiyan_logo.png",
    splashImage: "assets/abhiyan/abhiyan_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.aviyan",
    appStoreID: "",
  );
  static final CoOperative gomaGaneshCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/gomaGanesh/gomaGanesh_banner.png",
    clientCode: 'TGUUH8ZXOE',
    clientSecret: "209233",
    backgroundImage: "assets/gomaGanesh/gomaGanesh_background_image.png",
    coOperativeName: 'Goma Ganesh',
    coOperativeLogo: "assets/gomaGanesh/gomaGanesh_logo.png",
    splashImage: "assets/gomaGanesh/gomaGanesh_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.gomaGanesh",
    appStoreID: "6455685898",
  );
  static final CoOperative alankarCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/alankar/alankar_banner.png",
    clientCode: 'GY05KRRDJG',
    clientSecret: "132543",
    backgroundImage: "assets/alankar/alankar_background_image.png",
    coOperativeName: 'Abhiyan',
    coOperativeLogo: "assets/alankar/alankar_logo.png",
    splashImage: "assets/alankar/alankar_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.alankar",
    appStoreID: "6457205347",
  );
  static final CoOperative manankCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/manank/manank_banner.png",
    clientCode: 'CGJQ1YHKZ3',
    clientSecret: "149077",
    backgroundImage: "assets/manank/manank_background_image.png",
    coOperativeName: 'Abhiyan',
    coOperativeLogo: "assets/manank/manank_logo.png",
    splashImage: "assets/manank/manank_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.manank",
    appStoreID: "6457205219",
  );

  static final CoOperative arthaBagCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/arthaBag/arthaBag_banner.png",
    clientCode: 'YT2HELT9H8',
    clientSecret: "117188",
    backgroundImage: "assets/arthaBag/arthaBag_background_image.png",
    coOperativeName: 'Abhiyan',
    coOperativeLogo: "assets/arthaBag/arthaBag_logo.png",
    splashImage: "assets/arthaBag/arthaBag_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.arthabag",
    appStoreID: "",
  );

  static final CoOperative kamanaCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/kamana/kamana_banner_v2.png",
    clientCode: 'LQ7QMJ5NRB',
    clientSecret: "118107",
    backgroundImage: "assets/kamana/kamana_background_image.png",

    coOperativeName: 'Kamana',
    coOperativeLogo: "assets/kamana/kamana_logo.png",
    splashImage: "assets/kamana/kamana_splash_image.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.kamana",
    appStoreID: "",
  );

  static final CoOperative uttargangaCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/uttarganga/uttarganga_banner_2.png",
    clientCode: '9DZS5N3TOY',
    clientSecret: "112213",
    backgroundImage: "assets/uttarganga/uttarganga_background_image.png",

    coOperativeName: 'Uttarganga',
    coOperativeLogo: "assets/uttarganga/uttarganga_logo.png",
    splashImage: "assets/uttarganga/uttarganga_splash.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.uttarganga",
    appStoreID: "",
  );

////********************** Sahakarya ***********************//////
  static final CoOperative shakaryaCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/sahakarya/sahakarya_banner.png",
    clientCode: 'SMTZ26RF75',
    clientSecret: "194009",
    backgroundImage: "assets/sahakarya/sahakarya_background_image.png",
    coOperativeName: 'Sahakarya',
    coOperativeLogo: "assets/sahakarya/sahakarya_logo.png",
    splashImage: "assets/sahakarya/sahakarya_splash_image.png",
    primaryColor: const Color(0xFF015017),
    packageName: "com.devanasoft.sahakarya",
    appStoreID: "6451393046",
  );

  static final CoOperative janadharaCoop = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/janadhara/janadhara_banner.png",
    backgroundImage: "assets/janadhara/janadhara_background_image.png",
    clientCode: '6M0D7LSVNV',
    coOperativeName: 'Janadhara',
    coOperativeLogo: 'assets/janadhara/janadhar_logo.png',
    clientSecret: "180509",
    splashImage: "assets/janadhara/Janadhara-Splash-Resized.png",
    primaryColor: const Color(0xFF0b67bb),
    packageName: "com.devanasoft.janadhara",
    appStoreID: "6455494708",
  );

  static final CoOperative shreeaaju = CoOperative(
    appStoreID: "",
    packageName: "com.devanasoft.shreeaaju",
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/shreeaaju/shreeaaju_banner.png",
    backgroundImage: "assets/shreeaaju/shreeaju_background.png",

    clientCode: 'D6CIBSGVA0',
    coOperativeName: 'Shree Aaju',
    coOperativeLogo: 'assets/shreeaaju/shreeaaju_logo.png',

    clientSecret: "155993",
    splashImage: "assets/shreeaaju/shreeaaju_splash.png",
    primaryColor: const Color(0xFF0b67bb),
  );
  static final CoOperative shreeamitra = CoOperative(
    appStoreID: "",
    packageName: "com.devanasoft.shreemitra",
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/shreemitra/shreemitra_banner.png",
    backgroundImage: "assets/shreemitra/shreemitra_background.png",

    clientCode: 'JYVHE7GL7S',
    coOperativeName: 'Shree Mitra',
    coOperativeLogo: 'assets/shreemitra/shreemitra_logo.png',

    clientSecret: "128632",
    splashImage: "assets/shreemitra/shreemitra_splash.png",
    primaryColor: const Color(0xFF0b67bb),
  );

  static final CoOperative kipoo = CoOperative(
    appStoreID: "",
    packageName: "com.devanasoft.kipoo",
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/kipoo/kipoo_banner.png",
    backgroundImage: "assets/kipoo/kipoo_background.png",

    clientCode: 'JRC56V3YN4',
    coOperativeName: 'Kipoo',
    coOperativeLogo: 'assets/kipoo/kipoo_logo.png',

    clientSecret: "135559",
    splashImage: "assets/kipoo/kipoo_splash.png",
    primaryColor: const Color(0xFF0b67bb),
  );
  static final CoOperative suryadev = CoOperative(
    appStoreID: "",
    packageName: "com.devanasoft.suryadev",
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/suryadev/suryadev_banner.png",
    backgroundImage: "assets/suryadev/suryadev_background.png",

    clientCode: 'RVERAQI2XY',
    coOperativeName: 'Suryadev',
    coOperativeLogo: 'assets/suryadev/suryadev_logo.png',

    clientSecret: "181746",
    splashImage: "assets/suryadev/suryadev_splash.png",
    primaryColor: const Color(0xFF0b67bb),
  );

  static final CoOperative uddhamshil = CoOperative(
    appStoreID: "",
    packageName: "com.devanasoft.suryadev",
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/uddhamshil/uddhamshil_banner.png",
    backgroundImage: "assets/uddhamshil/uddhamshil_background.png",

    clientCode: 'VBJ07QPYUP',
    coOperativeName: 'Uddhamshil',
    coOperativeLogo: 'assets/uddhamshil/uddhamshil_logo.png',

    clientSecret: "133034",
    splashImage: "assets/uddhamshil/uddhamshil_splash.png",
    primaryColor: const Color(0xFF0b67bb),
  );
  static final CoOperative shreeNavaprabhat = CoOperative(
    appStoreID: "",
    packageName: "com.devanasoft.suryadev",
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/navaprabhat/navaprabhat_banner.png",
    backgroundImage: "assets/navaprabhat/nawaprabhat_background_2.png",

    clientCode: '9PI6BYBK1J',
    coOperativeName: 'Shree Navaprabhat',
    coOperativeLogo: 'assets/navaprabhat/navaprabhat_logo.png',

    clientSecret: "163873",
    splashImage: "assets/navaprabhat/navaprabhat_splash.png",
    primaryColor: const Color(0xFF0b67bb),
  );

// //  DEV TEST700746
  static final CoOperative devLive = CoOperative(
    backgroundImage: "assets/images/ismart_background_image.jpg",
    bannerImage: "assets/images/ismart_banner.png",
    coOperativeName: '',
    coOperativeLogo: Assets.ismartLogo,
    clientCode: 'EHVNI7CZJ3',
    clientSecret: "126489",
    splashImage: "assets/images/ismart_splash.jpg",

    primaryColor: const Color(0xFF010C80),
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    packageName: "com.devanasoft.ismart",
    appStoreID: "",
  );

  // // // // DEV TEST70074
  // static final CoOperative development = CoOperative(
  //   backgroundImage: "assets/images/ismart_background_image.jpg",

  //   bannerImage: "assets/images/ismart_banner.png",

  //   //  bannerImage: "assets/images/isamrt_banner.jpg",
  //   baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
  //   clientCode: 'EHVNI7CZJ3',
  //   coOperativeName: '',
  //   coOperativeLogo: Assets.ismartLogo,
  //   clientSecret: "126489",
  //   splashImage: "assets/images/ismart_splash.jpg",

  //   primaryColor: const Color(0xFF010C80),
  // );

  // DEV TEST70074
  static final CoOperative development = CoOperative(
    baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
    bannerImage: "assets/images/ismart_banner.png",
    clientCode: 'VBMRDWEVFV',
    backgroundImage: "assets/images/ismart_background_image.jpg",
    coOperativeName: '',
    coOperativeLogo: Assets.ismartLogo,
    clientSecret: "199204",
    splashImage: "assets/images/ismart_splash.jpg",
    primaryColor: const Color(0xFF010C80), packageName: "com.devanasoft.ismart",
    appStoreID: "",
  );
}
