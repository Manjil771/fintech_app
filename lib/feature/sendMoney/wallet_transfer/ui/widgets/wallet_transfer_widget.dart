import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/widgets/wallet_box_widget.dart';

class WalletTransferWidget extends StatefulWidget {
  const WalletTransferWidget({super.key});

  @override
  State<WalletTransferWidget> createState() => _WalletTransferWidgetState();
}

class _WalletTransferWidgetState extends State<WalletTransferWidget> {
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,
        title: "Wallet Transfer",
        detail: "Load Money to your preffered wallet account",
        showRoundBotton: false,
        topbarName: "Send Money",
        showTitleText: true,
        body: Container(
          height: _height * 0.6,
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
                  if (state is CommonLoading) {
                    return const CommonLoadingWidget();
                  }
                  if (state is CommonDataFetchSuccess<WalletModel>) {
                    List<WalletModel> _walletsList = state.data;

                    return Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1 / 0.85),
                        itemCount: _walletsList.length,
                        itemBuilder: (context, index) =>
                            WalletBoxWidget(wallet: _walletsList[index]),
                      ),
                    );
                  } else if (state is CommonError) {
                    return Text(state.message);
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

  final List images = [
    "unnamed 1.png",
    "khalti 1.png",
    "unnamed (1) 1.png",
    "Group 975.png",
  ];

  final List names = [
    "eSewa",
    "Khalti",
    "Sajilo Pay",
    "PrabhuPay",
  ];
}
