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
    baseUrl: 'http://103.198.9.222:1231/',
    bannerImage: 'assets/chandragiri.png',
    clientCode: 'CHAN6566',
    coOperativeName: 'ChandraGiri CoOperative',
    coOperativeLogo: 'assets/chandragiri.png',
    clientSecret: "",
  );

  static final CoOperative development = CoOperative(
    baseUrl: 'http://103.198.9.222:1231/',
    bannerImage: 'assets/images/Group 1105.png',
    clientCode: 'VBMRDWEVFV',
    coOperativeName: '',
    coOperativeLogo: '',
    clientSecret: "199204",
  );
}
