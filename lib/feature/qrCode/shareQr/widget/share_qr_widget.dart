import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/qrCode/shareQr/resources/qr_cubit.dart';

class ShareQrWidget extends StatefulWidget {
  const ShareQrWidget({super.key});

  @override
  State<ShareQrWidget> createState() => _ShareQrWidgetState();
}

class _ShareQrWidgetState extends State<ShareQrWidget> {
  final detail =
      RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
          .selectedAccount
          .value!;
  @override
  void initState() {
    context.read<QrCubit>().generateQr(
        customerName: detail.accountHolderName, customerId: detail.id);
    super.initState();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;
    final userDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .selectedAccount
        .value!;
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,
        showRoundBotton: false,
        showTitleText: false,
        topbarName: "Share Qr",
        body: BlocConsumer<QrCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && !_isLoading) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }

            // if (state is CommonError) {
            //   showPopUpDialog(
            //     context: context,
            //     message: state.message,
            //     title: "Error",
            //     showCancelButton: false,
            //     buttonCallback: () {
            //       NavigationService.pop();
            //     },
            //   );
            // }
          },
          builder: (context, state) {
            if (state is CommonStateSuccess) {
              return Column(
                children: [
                  SvgPicture.asset(
                    "assets/icons/Group 913.svg",
                    color: Color(0XFF4E4E4E),
                    height: _height * 0.04,
                  ),
                  const Text(
                    "My QR Code",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  // Text("Your QR Code is Displayed below.",
                  //     textAlign: TextAlign.center,
                  //     style: Theme.of(context).textTheme.titleSmall),
                  Image.network(
                    RepositoryProvider.of<CoOperative>(context).baseUrl +
                        state.data["data"]["details"]["QRCodePath"].toString(),
                    height: _height * 0.4,
                  ),
                  KeyValueTile(
                    title: "Name",
                    value: detail.accountHolderName,
                  ),
                  KeyValueTile(
                    title: "Account Number",
                    value: detail.accountNumber,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     shareMyQr(context),
                  //     phonePayQr(context),
                  //   ],
                  // ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
