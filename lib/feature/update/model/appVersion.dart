class AppVersion {
  int major;
  int minor;
  int patch;

  AppVersion({
    required this.major,
    required this.minor,
    required this.patch,
  });

  factory AppVersion.fromString(String version) {
    final _res =
        version.trim().split('.').map((i) => int.tryParse(i) ?? 0).toList();
    int tempMajor = 0;
    int tempMinor = 0;
    int tempPatch = 0;
    for (int i = 0; i < _res.length; i++) {
      if (i == 0) {
        tempMajor = _res[0];
      } else if (i == 1) {
        tempMinor = _res[1];
      } else if (i == 2) {
        tempPatch = _res[2];
      }
    }
    return AppVersion(
      major: tempMajor,
      minor: tempMinor,
      patch: tempPatch,
    );
  }
}
