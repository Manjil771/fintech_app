import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/appContact/cubit/app_contact_cubit.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  getData() {
    return RepositoryProvider.of<AppContactRepository>(context)
        .appContactDetail
        .findValueString("contactNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(getData()),
    );
  }
}

class TestScreens extends StatefulWidget {
  const TestScreens({Key? key}) : super(key: key);

  @override
  State<TestScreens> createState() => _TestScreensState();
}

class _TestScreensState extends State<TestScreens> {
  getData() {
    return RepositoryProvider.of<AppContactRepository>(context)
        .appContactDetail
        .findValueString("contactNumber");
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Scaffold(
      body: BlocProvider(
        create: (context) => AppContactCubit(
            appContactRepository:
                RepositoryProvider.of<AppContactRepository>(context))
          ..fetchAppContact(),
        child: BlocBuilder<AppContactCubit, CommonState>(
          builder: (context, state) {
            return Center(
                child: ElevatedButton(
              child: Text(state.toString() + getData()),
              onPressed: () {
                openFile(
                    url: "https://www.devanasoft.com.np/images/11.jpg",
                    fileName: "video.jpg");
              },
            ));
          },
        ),
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
