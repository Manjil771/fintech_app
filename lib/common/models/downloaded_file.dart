import 'dart:convert';

class DownloadedFile {
  final String fileName;
  final String filePath;
  final DateTime downloadedDate;

  DownloadedFile({
    required this.fileName,
    required this.filePath,
    required this.downloadedDate,
  });

  factory DownloadedFile.fromJson(Map<String, dynamic> json) => DownloadedFile(
        fileName: json["fileName"],
        filePath: json["filePath"],
        downloadedDate: DateTime.parse(json["downloadedDate"]),
      );

  static Map<String, dynamic> toJson(DownloadedFile file) => {
        "fileName": file.fileName,
        "filePath": file.filePath,
        "downloadedDate":
            "${file.downloadedDate.year.toString().padLeft(4, '0')}-${file.downloadedDate.month.toString().padLeft(2, '0')}-${file.downloadedDate.day.toString().padLeft(2, '0')}",
      };

  static String encode(List<DownloadedFile> files) => json.encode(
        files
            .map<Map<String, dynamic>>((file) => DownloadedFile.toJson(file))
            .toList(),
      );

  static List<DownloadedFile> decode(String files) {
    if (files.isEmpty) {
      return [];
    } else {
      return (json.decode(files) as List<dynamic>)
          .map<DownloadedFile>((item) => DownloadedFile.fromJson(item))
          .toList();
    }
  }
}
