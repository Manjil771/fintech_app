import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/banking/cheque/screen/cheque_block_page.dart';
import 'package:ismart/feature/banking/cheque/screen/cheque_request_page.dart';

class ChequeWidget extends StatelessWidget {
  const ChequeWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
      showDetail: false,
      body: SizedBox(
        height: _height * 0.6,
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Column(
            children: const [
              TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Color(0xFF989898),
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                indicatorColor: Colors.transparent,
                automaticIndicatorColorAdjustment: true,
                tabs: [
                  Tab(text: "Cheque Book"),
                  Tab(text: "Cheque Stop"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    ChequeRequestScreen(),
                    ChequeBlocScreen(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      topbarName: "Banking",
      showTitleText: false,
      showRoundBotton: false,
    ));
  }
}
