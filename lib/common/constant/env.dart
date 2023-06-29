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

  String baseUrl;
  String clientCode;
  String clientSecret;
  String coOperativeName;
  String bannerImage;
  String coOperativeLogo;

  CoOperative copyWith({required String clientCode}) {
    return CoOperative(
      clientCode: clientCode,
      clientSecret: clientSecret,
      coOperativeName: coOperativeName,
      bannerImage: bannerImage,
      coOperativeLogo: coOperativeLogo,
      baseUrl: baseUrl,
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
  static final CoOperative development = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np/', // 9866556708 : 24878
    bannerImage: "assets/images/isamrt_banner.jpg",
    clientCode: 'EHVNI7CZJ3',
    coOperativeName: '',
    coOperativeLogo: Assets.ismartLogo,
    clientSecret: "126489",
  );

  // // DEV TEST70074
  // static final CoOperative development = CoOperative(
  //   splashImage: "",
  //   baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'VBMRDWEVFV',
  //   coOperativeName: '',
  //   coOperativeLogo: Assets.ismartLogo,
  //   clientSecret: "199204",
  // );
}
