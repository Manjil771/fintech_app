class UrlUtils {
  static Uri getUri({required String url, Map<String, dynamic>? params}) {
    final _temp = Uri.parse(url);
    if (url.contains("https://")) {
      final _uri = Uri.https(
        _temp.authority,
        _temp.path,
        params?.map((key, value) => MapEntry(key, value.toString())),
      );
      return _uri;
    } else {
      final _uri = Uri.http(
        _temp.authority,
        _temp.path,
        params?.map((key, value) => MapEntry(key, value.toString())),
      );
      return _uri;
    }
  }

  static String convertUrlToId(String url) {
    if (url.isEmpty) {
      return url;
    } else if (!url.contains("http") && (url.length == 11)) {
      return url;
    }
    url = url.trim();

    for (RegExp exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      if (exp.hasMatch(url)) {
        return exp.firstMatch(url)!.group(1) ?? "";
      }
    }

    return "";
  }
}
