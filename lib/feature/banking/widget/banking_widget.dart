import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';

class BankingWidget extends StatefulWidget {
  const BankingWidget({Key? key}) : super(key: key);

  @override
  State<BankingWidget> createState() => _BankingWidgetState();
}

class _BankingWidgetState extends State<BankingWidget> {
  @override
  void initState() {
    super.initState();
    context.read<AppServiceCubit>().fetchAppService();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;

    return CommonContainer(
      showDetail: false,
      topbarName: "Banking",
      showTitleText: false,
      showRoundBotton: false,
      showBackBotton: false,
      body: Column(
        children: [
          Container(
              width: double.infinity,
              // height: _height * 0.7,
              child: Container(
                child: BlocBuilder<AppServiceCubit, CommonState>(
                    builder: (context, state) {
                  if (state
                      is CommonDataFetchSuccess<AppServiceManagementModel>) {
                    final filteredItems = state.data
                        .where((item) =>
                            item.uniqueIdentifier
                                .toString()
                                .toLowerCase()
                                .contains("loan_payment".toLowerCase()) &&
                            item.status.toString().toLowerCase() ==
                                "Active".toLowerCase())
                        .toList();

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredItems.isEmpty ? 5 : itemName.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) => CommonGridViewContainer(
                        onContainerPress: () {
                          NavigationService.pushNamed(
                              routeName: onPress[index]);
                        },
                        margin: const EdgeInsets.all(8),
                        containerImage: images[index],
                        title: itemName[index],
                      ),
                    );
                  }
                  if (state is CommonLoading) {
                    return CommonLoadingWidget();
                  } else {
                    return Container();
                  }
                }),
              )),
        ],
      ),
    );
  }

  final itemName = [
    "Account Info",
    "Balance Inquiry",
    "Statement",
    "Fund Transfer",
    'Cheque Request',
    'Loan'
  ];
  final images = [
    Assets.accountInfo,
    Assets.balanceInquiry,
    Assets.statement,
    Assets.sendMoneyRemit,
    Assets.chequeBookIcon,
    Assets.loanIcon
  ];
  final onPress = [
    Routes.profileScreen,
    Routes.balanceInquiry,
    Routes.statementPage,
    Routes.internalCooperative,
    Routes.chequeScreen,
    Routes.loanPage,
  ];
}
