import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/models/downloaded_file.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:open_filex/open_filex.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({Key? key}) : super(key: key);

  @override
  State<DownloadWidget> createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  List<DownloadedFile> _dowloadedFiles = [];

  @override
  void initState() {
    _populateDownloads();
    super.initState();
  }

  _populateDownloads() async {
    _dowloadedFiles = await SharedPref.getDownloads();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
          showRoundBotton: false,
          title: "Downloads".tr(),
          detail: "All your downloaded documents are stored here.".tr(),
          showDetail: true,
          topbarName: "Downloads".tr(),
          body: Container(
            height: 500.hp,
            child: _dowloadedFiles.isNotEmpty
                ? ListView.builder(
                    itemCount: _dowloadedFiles.length,
                    itemBuilder: (context, index) {
                      return CommonDetailBox(
                        leadingImage: Assets.statement,
                        title: _dowloadedFiles[index].fileName,
                        detail: "Downloaded on :" +
                            _dowloadedFiles[index].downloadedDate.toString(),
                        showTrailingIcon: false,
                        onBoxPressed: () {
                          OpenFilex.open(_dowloadedFiles[index].filePath);
                        },
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No downloads available.".tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
          )),
    );
  }
}
