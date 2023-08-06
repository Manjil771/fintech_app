import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/qrCode/shareQr/resources/qr_cubit.dart';
import 'package:ismart/feature/qrCode/shareQr/widget/external_qr_widget.dart';
import 'package:ismart/feature/qrCode/shareQr/widget/internal_qr_widget.dart';

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

  bool isInternalQr = false;

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _height = SizeUtils.height;
    final _width = SizeUtils.width;
    final userDetail = RepositoryProvider.of<CustomerDetailRepository>(context)
        .selectedAccount
        .value!;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        showDetail: false,
        showRoundBotton: false,
        showTitleText: false,
        topbarName: "My Qr",
        body: Container(
          height: _height / 1.5,
          child: BlocConsumer<QrCubit, CommonState>(
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
            },
            builder: (context, state) {
              if (state is CommonStateSuccess) {
                return Container(
                  child: (state.data["data"]?["details"]?["ExternalQRURL"] ??
                              "")
                          .toString()
                          .isNotEmpty
                      ? DefaultTabController(
                          initialIndex: 0,
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: Colors.black,
                                unselectedLabelColor: const Color(0xFF989898),
                                labelStyle: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                indicatorColor: _theme.primaryColor,
                                automaticIndicatorColorAdjustment: true,
                                tabs: const [
                                  Tab(text: "External Qr"),
                                  Tab(text: "Internal Qr"),
                                ],
                              ),
                              SizedBox(height: _height * 0.02),
                              Expanded(
                                child: TabBarView(
                                  children: [
                                    ExternalQrWidget(
                                        qrPath: state.data["data"]["details"]
                                                ["ExternalQRURL"]
                                            .toString()),
                                    InternalQrWidget(
                                        qrPath: state.data["data"]["details"]
                                                ["QRCodePath"]
                                            .toString()),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      : InternalQrWidget(
                          qrPath: state.data["data"]["details"]["QRCodePath"]
                              .toString()),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
