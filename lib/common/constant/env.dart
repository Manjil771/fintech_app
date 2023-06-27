import 'package:ismart/common/constant/assets.dart';

class CoOperative {
  CoOperative({
    required this.clientCode,
    required this.clientSecret,
    required this.coOperativeName,
    required this.bannerImage,
    required this.coOperativeLogo,
    required this.baseUrl,
  });

  final String baseUrl;
  final String clientCode;
  final String clientSecret;
  final String coOperativeName;
  final String bannerImage;
  final String coOperativeLogo;
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

<<<<<<< HEAD
//   //******************* Janadhara******************//
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

  //******************* LIVE ************************* //
=======
  // DEV
  // static final CoOperative development = CoOperative(
  //   baseUrl: 'https://mbank.com.np/', // 9802013689 :97684
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'H6FXNHXS61',
  //   coOperativeName: '',
  //   coOperativeLogo: '',
  //   clientSecret: "175391",
  // );

>>>>>>> 3112c01e38283097228defd4b5ca8df2ec90ec42
  static final CoOperative development = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/images/isamrt_banner.jpg",
    clientCode: 'EHVNI7CZJ3',
    coOperativeName: '',
    coOperativeLogo: Assets.ismartLogo,
    clientSecret: "126489",
<<<<<<< HEAD
    splashImage: "",
  );

  // // DEV TEST70074
  // static final CoOperative development = CoOperative(
  //   splashImage: "",
=======
  );

  // // LIVE
  // DEV
  // static final CoOperative development = CoOperative(
>>>>>>> 3112c01e38283097228defd4b5ca8df2ec90ec42
  //   baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'VBMRDWEVFV',
  //   coOperativeName: '',
  //   coOperativeLogo: Assets.ismartLogo,
  //   clientSecret: "199204",
  // );
}
