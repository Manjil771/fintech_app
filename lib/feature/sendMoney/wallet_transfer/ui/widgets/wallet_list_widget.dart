import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/widgets/wallet_box_widget.dart';

class WalletListWidget extends StatefulWidget {
  const WalletListWidget({super.key});

  @override
  State<WalletListWidget> createState() => _WalletListWidgetState();
}

class _WalletListWidgetState extends State<WalletListWidget> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        title: "Wallet Transfer".tr(),
        detail: "Load Money to your preferred wallet account".tr(),
        showRoundBotton: false,
        topbarName: "Load Wallet".tr(),
        showTitleText: true,
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<WalletListCubit, CommonState>(
                builder: (context, state) {
                  // if (state is CommonLoading) {
                  //   return const CommonLoadingWidget();
                  // }
                  if (state is CommonDataFetchSuccess<WalletModel>) {
                    final List<WalletModel> _walletsList = state.data;

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, childAspectRatio: 1 / 0.85),
                      itemCount: _walletsList.length,
                      itemBuilder: (context, index) =>
                          WalletBoxWidget(wallet: _walletsList[index]),
                    );
                  } else if (state is CommonError) {
                    return NoDataScreen(
                        title: "No Wallet Found".tr(), details: "");
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // walletBox(context, index) {
  //   Size _= MediaQuery.of(context)._
  //   return InkWell(
  //     onTap: () {
  //       NavigationService.push(
  //         target: const LoadWalletFormScreen(
  //           name: "eSewa",
  //         ),
  //       );
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(30),
  //       margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
  //       width: _width * 0.2,
  //       height: _width * 0.4,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20),
  //         color: CustomTheme.gray,
  //       ),
  //       child: Column(
  //         children: [
  //           Expanded(child: Image.asset("assets/images/${images[index]}")),
  //           SizedBox(height: _height * 0.01),
  //           Text(names[index]),
  //         ],
  //       ),
  //     ),
  //   );

  // }
}
