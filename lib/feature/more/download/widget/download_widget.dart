import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_detail_box.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class DownloadWidget extends StatelessWidget {
  const DownloadWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          showRoundBotton: false,
          title: "Downloads",
          detail: "All your downloaded documents are stored here.",
          showDetail: true,
          topbarName: "More",
          body: Container(
            height: 500.hp,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return CommonDetailBox(
                    leadingIcon: Assets.statement,
                    title: "Statement Name",
                    showTrailingIcon: false,
                    onBoxPressed: () {});
              },
            ),
          )),
    );
  }
}
