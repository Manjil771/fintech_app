class Update {
  String currentVersion;
  String minimumVersionSupport;
  String whatsNew;

  Update({
    required this.currentVersion,
    required this.minimumVersionSupport,
    required this.whatsNew,
  });

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      currentVersion: json['current_version']?.toString() ?? '0.0.0',
      minimumVersionSupport: json['min_version']?.toString() ?? '0.0.0',
      whatsNew: json['whats_new'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_version'] = currentVersion;
    data['min_version'] = minimumVersionSupport;
    data['whats_new'] = whatsNew;
    return data;
  }
}
