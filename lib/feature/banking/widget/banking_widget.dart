import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';

class BankingWidget extends StatefulWidget {
  BankingWidget({Key? key}) : super(key: key);

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
            height: _height * 0.4,
            child: GridView.builder(
              itemCount: itemName.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) => CommonGridViewContainer(
                onContainerPress: () {
                  NavigationService.pushNamed(routeName: onPress[index]);
                },
                margin: const EdgeInsets.all(8),
                containerImage: images[index],
                title: itemName[index],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              height: _height * 0.2,
              child: Row(
                children: [
                  Container(
                    width: _width / 2.3,
                    child: CommonGridViewContainer(
                        containerImage: Assets.chequeBookIcon,
                        title: "Cheque Request"),
                  ),
                  Container(
                    width: _width / 2.3,
                    child: BlocConsumer<AppServiceCubit, CommonState>(
                        listener: (context, state) {
                      if (state is CommonLoading && !_isLoading) {
                        _isLoading = true;
                        showLoadingDialogBox(context);
                      } else if (state is! CommonLoading && _isLoading) {
                        _isLoading = false;
                        NavigationService.pop();
                      }

                      if (state is CommonError) {
                        showPopUpDialog(
                          context: context,
                          message: state.message,
                          title: "Error",
                          showCancelButton: false,
                          buttonCallback: () {
                            NavigationService.pop();
                          },
                        );
                      }
                    }, builder: (context, state) {
                      if (state is CommonDataFetchSuccess<
                          AppServiceManagementModel>) {
                        return state.data[5].status.toString().toLowerCase() !=
                                "Active".toLowerCase
                            ? CommonGridViewContainer(
                                containerImage: Assets.loanIcon,
                                title: state.data[5].name)
                            : Container();
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ],
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
    "Cheque Request",
    "Loan",
  ];
  final images = [
    Assets.accountInfo,
    Assets.balanceInquiry,
    Assets.statement,
    Assets.fundTransferIcon,
    Assets.chequeBookIcon,
    Assets.loanIcon,
  ];
  final onPress = [
    Routes.profileScreen,
    Routes.balanceInquiry,
    Routes.statementPage,
    Routes.anyBank,
    Routes.chequeScreen,
    Routes.profileScreen,
  ];
}
