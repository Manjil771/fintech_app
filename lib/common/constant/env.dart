class CoOperative {
  CoOperative({
    required this.clientCode,
    required this.coOperativeName,
    required this.bannerImage,
    required this.coOperativeLogo,
    required this.baseUrl,
  });

  final String baseUrl;
  final String clientCode;
  final String coOperativeName;
  final String bannerImage;
  final String coOperativeLogo;
}

class CoOperativeValue {
  static final CoOperative chandraGiriCoOperative = CoOperative(
    baseUrl: '113.78.8.200:1231',
    bannerImage: 'assets/chandragiri.png',
    clientCode: 'CHAN6566',
    coOperativeName: 'ChandraGiri CoOperative',
    coOperativeLogo: 'assets/chandragiri.png',
  );

  static final CoOperative development = CoOperative(
    baseUrl: 'https://pwapi.silkinv.com/api',
    bannerImage: '',
    clientCode: '',
    coOperativeName: '',
    coOperativeLogo: '',
  );
}
