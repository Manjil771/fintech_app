import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class TestScreens extends StatefulWidget {
  const TestScreens({Key? key}) : super(key: key);

  @override
  State<TestScreens> createState() => _TestScreensState();
}

class _TestScreensState extends State<TestScreens> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Scaffold(
      body: PageWrapper(
        body: Center(
            child: ElevatedButton(
          child: const Text("Text"),
          onPressed: () {
            openFile(
                url: "https://www.devanasoft.com.np/images/11.jpg",
                fileName: "video.jpg");
          },
        )),
      ),
    );
  }

  Future openFile({required String url, required String fileName}) async {
    final file = await downloadFile(url, fileName);

    OpenFilex.open(file.path);
    print("file path is ${file.path}");
  }

  Future<File> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    final response = await Dio().get(
      url,
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0),
    );
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(response.data);
    await raf.close();
    return file;
  }
}
