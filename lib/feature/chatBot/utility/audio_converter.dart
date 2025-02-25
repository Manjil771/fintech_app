// import 'dart:io';

// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:path_provider/path_provider.dart';

// Future<String?> convertM4AToWAV(String inputPath) async {
//   try {
//     // Get the directory to save the converted file
//     final directory = await getApplicationDocumentsDirectory();
//     final outputPath = '${directory.path}/output.wav';

//     // final session = await FFmpegKit.execute(
//     //   '-i $inputPath -acodec pcm_s16le -ar 44100 -ac 2 $outputPath');

//     // FFmpeg command to convert m4a to wav
//     // String command = '-i "$inputPath" "$outputPath"';
//     String command =
//         '-i $inputPath -acodec pcm_s16le -ar 44100 -ac 2 $outputPath';

//     // Execute the command
//     await FFmpegKit.execute(command);

//     // Check if the output file is created
//     if (File(outputPath).existsSync()) {
//       return outputPath;
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print("Error: $e");
//     return null;
//   }
// }
