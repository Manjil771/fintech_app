import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/models/common_gridview_model.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/widgets/wallet_box_widget.dart';

class LoanWidget extends StatelessWidget {
  LoanWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
          showRoundBotton: false,
          showTitleText: false,
          body: Container(
            child: Column(
              children: [
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) => CommonGridViewContainer(
                        containerImage: Assets.accountInfo,
                        onContainerPress: mylist[index].onPress,
                        title: mylist[index].title)),
              ],
            ),
          ),
          topbarName: "Loan"),
    );
  }

  final List<CommonGridViewModel> mylist = [
    CommonGridViewModel(
        image: Assets.loanIcon,
        title: "Loan Information",
        onPress: () {
          NavigationService.pushNamed(routeName: Routes.loanInformationPage);
        }),
    CommonGridViewModel(
        image: Assets.loanIcon,
        title: "Loan Schedule",
        onPress: () {
          NavigationService.pushNamed(routeName: Routes.loanSchedulePage);
        }),
    CommonGridViewModel(
        image: Assets.statement,
        title: "Loan Statement",
        onPress: () {
          NavigationService.pushNamed(routeName: Routes.statementPage);
        })
  ];
}
