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
  static final CoOperative chandraGiriCoOperative = CoOperative(
    baseUrl: 'http://202.63.242.139:9091/',
    bannerImage: 'assets/chandragiri.png',
    clientCode: 'CHAN6566',
    coOperativeName: 'ChandraGiri CoOperative',
    coOperativeLogo: 'assets/chandragiri.png',
    clientSecret: "",
  );

  // // DEV
  // static final CoOperative development = CoOperative(
  //   baseUrl: 'http://103.198.9.222:1231/', // 9866556708 : 24878
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'VBMRDWEVFV',
  //   coOperativeName: '',
  //   coOperativeLogo: '',
  //   clientSecret: "199204",
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

  // static final CoOperative development = CoOperative(
  //   baseUrl: 'https://mbank.com.np', // 9802013689 :97684
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'H6FXNHXS61',
  //   coOperativeName: '',
  //   coOperativeLogo: '',
  //   clientSecret: "175391",
  // );

  // iSmart Build
  static final CoOperative development = CoOperative(
    baseUrl: 'https://ismart.devanasoft.com.np', // 9802013689 :97684
    bannerImage: "assets/images/isamrt_banner.jpg",
    clientCode: 'EHVNI7CZJ3',
    coOperativeName: '',
    coOperativeLogo: '',
    clientSecret: "126489",
  );

  // Staging
  // static final CoOperative development = CoOperative(
  //   baseUrl: 'https://mbank.com.np/',
  //   bannerImage: "assets/images/isamrt_banner.jpg",
  //   clientCode: 'H6FXNHXS61',
  //   coOperativeName: '',
  //   coOperativeLogo: '',
  //   clientSecret: "175391",
  // );
}
