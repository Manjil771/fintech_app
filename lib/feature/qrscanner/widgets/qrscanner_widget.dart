import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/constant/slugs.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/qr_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/custom_shape_border.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
import 'package:ismart/feature/eteller/screen/eteller_page.dart';
import 'package:ismart/feature/favorite/addAccount/screen/add_fav_account_page.dart';
import 'package:ismart/feature/payload/payload_page.dart';
import 'package:ismart/feature/qrCode/shareQr/screen/share_qr_page.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/any_bank_page.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/screen/internal_cooperative_page.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/screens/load_wallet_form_screen.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../common/http/response.dart';

class QRScannerWidgets extends StatefulWidget {
  final List<WalletModel> walletLists;
  final String? remarks;

  const QRScannerWidgets({
    Key? key,
    this.remarks,
    required this.walletLists,
  }) : super(key: key);

  @override
  State<QRScannerWidgets> createState() => _QRScannerWidgetsState();
}

class _QRScannerWidgetsState extends State<QRScannerWidgets>
    with SingleTickerProviderStateMixin {
  bool _isScanned = false;
  late AnimationController animationController;
  late Animation<double> _animation;
  bool _isLoading = false;
  MobileScannerController cameraController = MobileScannerController();
  StreamSubscription? _cameraSubscription;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation =
        Tween<double>(begin: 0, end: 170.wp).animate(animationController);
    animationController.forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
  }

  @override
  dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    final _qrSize = 200.wp;
    final _verticalMaxSize = (SizeUtils.height - _qrSize) / 2;
    final _horizontalMaxSize = (SizeUtils.width - _qrSize) / 2;
    return BlocListener<UtilityPaymentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading && _isLoading == false) {
          _isLoading = true;
          showLoadingDialogBox(context);
        } else if (state is! CommonLoading && _isLoading) {
          _isLoading = false;
          NavigationService.pop();
        } else if (state is CommonError) {
          showPopUpDialog(
            context: context,
            message: state.message,
            title: "Error",
            showCancelButton: false,
            buttonCallback: () {
              NavigationService.pop();
              NavigationService.pop();
            },
            buttonText: "Okay",
          );
        }

        if (state is CommonStateSuccess<UtilityResponseData>) {
          final UtilityResponseData _response = state.data;
          if (_response.code == "M0000") {
            if (_response.findValue(primaryKey: "bankTransfer") == true &&
                _response
                    .findValue(
                        primaryKey: "accountDetails",
                        secondaryKey: "branchCode")
                    .toString()
                    .isEmpty) {
              if (appServiceFilter(
                          identifier: Slugs.bankTransfer, state: appSeriveList)
                      .status ==
                  "Active") {
                showGeneralDialog(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PopScope(
                      canPop: false,
                      onPopInvoked: (didPop) async {
                        if (didPop) {
                          return;
                        }
                        NavigationService.pushNamedAndRemoveUntil(
                            routeName: Routes.dashboard);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18)),
                            padding: const EdgeInsets.all(18),
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                            child: Column(children: [
                              CustomRoundedButtom(
                                  title: "Fund Transfer",
                                  onPressed: () {
                                    NavigationService.pushReplacement(
                                        target: AnyBankpage(
                                      isScanQr: true,
                                      remarks: widget.remarks,
                                      accountName: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "accountName",
                                      ),
                                      accountNumber: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "accountNumber",
                                      ),
                                      bankCode: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "bankCode",
                                      ),
                                      bankName: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "bankName",
                                      ),
                                    ));
                                  }),
                              SizedBox(height: 15.hp),
                              CustomRoundedButtom(
                                  title: "Add Favorite Account",
                                  onPressed: () {
                                    NavigationService.pushReplacement(
                                        target: AddFavAccountPage(
                                      accountNumber: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "accountNumber",
                                      ),
                                      accountName: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "accountName",
                                      ),
                                      bankCode: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "bankCode",
                                      ),
                                      bankName: _response.findValue(
                                        primaryKey: "accountDetails",
                                        secondaryKey: "bankName",
                                      ),
                                    ));
                                  })
                            ]),
                          ),
                        ],
                      ),
                    );
                  },
                  context: context,
                );
              } else {
                showPopUpDialog(
                  context: context,
                  title: "INFO",
                  message: "Invalid QR",
                  showCancelButton: false,
                  buttonCallback: () {
                    NavigationService.pop();
                    NavigationService.pop();
                  },
                  buttonText: "Okay",
                );
              }
            }
            if ((_response.findValue(primaryKey: "internalFundTransfer") ==
                    true) ||
                _response.findValue(primaryKey: "bankTransfer") == true &&
                    _response
                        .findValue(
                            primaryKey: "accountDetails",
                            secondaryKey: "branchCode")
                        .toString()
                        .isNotEmpty) {
              NavigationService.pushReplacement(
                  target: InternalCooperativePage(
                remarks: widget.remarks,
                accountName: _response.findValue(
                  primaryKey: "accountDetails",
                  secondaryKey: "accountName",
                ),
                accountNumber: _response.findValue(
                  primaryKey: "accountDetails",
                  secondaryKey: "accountNumber",
                ),
                branchCode: _response.findValue(
                  primaryKey: "accountDetails",
                  secondaryKey: "branchCode",
                ),
              ));
            }
          } else {
            showPopUpDialog(
              context: context,
              message: _response.message,
              title: _response.status,
              buttonCallback: () {
                NavigationService.pop();
              },
              buttonText: "Okay",
            );
          }
        }
      },
      child:
          BlocBuilder<AppServiceCubit, CommonState>(builder: (context, state) {
        if (state is CommonDataFetchSuccess<AppServiceManagementModel>) {
          appSeriveList = state.data;
          final filteredItems = state.data
              .where(
                (item) =>
                    item.type
                        .toString()
                        .toLowerCase()
                        .contains("qrIcon".toLowerCase()) &&
                    item.status.toLowerCase() == "Active".toLowerCase(),
              )
              .toList();
          return Scaffold(
            body: Stack(
              children: [
                MobileScanner(
                  fit: BoxFit.cover,
                  controller: cameraController,
                  onDetect: _onQRCodeDetect,
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: ShapeDecoration(
                    shape: CustomShapeBorder(
                      cutOutWidth: _qrSize,
                      cutOutHeight: _qrSize,
                      borderColor: _theme.primaryColor,
                      overlayColor: _theme.primaryColor.withOpacity(0.56),
                      borderWidth: 6,
                      borderRadius: 15,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: _verticalMaxSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.hp),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomCachedNetworkImage(
                                  url: RepositoryProvider.of<CoOperative>(
                                          context)
                                      .coOperativeLogo
                                      .toString(),
                                  fit: BoxFit.fitHeight,
                                  height: 60.hp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.hp),
                        Text(
                          "Scan and Pay",
                          style: _textTheme.displayMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25.hp),
                        Text(
                          "Please allign the QR within frame.",
                          style: _textTheme.titleLarge!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 30.hp),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: _horizontalMaxSize - 20.wp,
                  top: _verticalMaxSize - 5.wp,
                  bottom: _verticalMaxSize - 5.wp,
                  left: _horizontalMaxSize - 20.wp,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: _animation.value),
                                child: child,
                              )
                            ],
                          );
                        },
                        child: Container(
                          // height: 30,
                          width: _qrSize,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _theme.primaryColor.withOpacity(0.5),
                                Colors.white.withOpacity(0.04),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 60,
                  child: Container(
                    height: _verticalMaxSize,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Assets.ismartSlogan,
                          height: 60.hp,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: CustomTheme.symmetricHozPadding,
                  top: _verticalMaxSize,
                  bottom: _verticalMaxSize,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: cameraController.torchState,
                        builder: (context, flashStatus, _) {
                          return CustomIconButton(
                            icon: flashStatus == TorchState.on
                                ? Icons.flash_on_rounded
                                : Icons.flash_off_rounded,
                            shadow: false,
                            iconSize: 22,
                            verticalPadding: 6,
                            horizontalPadding: 6,
                            backgroundColor: Colors.transparent,
                            iconColor: Colors.white,
                            onPressed: () async {
                              await cameraController.toggleTorch();
                            },
                          );
                        },
                      ),
                      CustomIconButton(
                        icon: Icons.image,
                        shadow: false,
                        iconSize: 22,
                        verticalPadding: 6,
                        horizontalPadding: 6,
                        backgroundColor: Colors.transparent,
                        iconColor: Colors.white,
                        onPressed: () async {
                          final _res = await QRUtils.checkQRCodeFromGallery();
                          if (_res.status == Status.Success &&
                              (_res.data?.isNotEmpty ?? false)) {
                            _processScannedQR(qrCode: _res.data ?? "");
                          } else if (_res.message?.isNotEmpty ?? false) {
                            NavigationService.pop();
                            showPopUpDialog(
                              context: context,
                              message: _res.message ?? "Invalid QR Code.",
                              showCancelButton: false,
                              buttonCallback: () {
                                NavigationService.pop();
                              },
                              title: 'Scan QR ',
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 260,
                  child: Container(
                    height: 40.hp,
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(
                              filteredItems.length,
                              (index) => CustomCachedNetworkImage(
                                url: RepositoryProvider.of<CoOperative>(context)
                                        .baseUrl +
                                    filteredItems[index].imageUrl.toString(),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            // Image.asset(
                            //   "assets/images/ismart_logo_only.png",
                            //   fit: BoxFit.fitHeight,
                            // ),
                          ],
                        ),
                      ),
                      // child: ListView.builder(
                      //   scrollDirection: Axis.horizontal,
                      //   itemBuilder: (context, index) {
                      //     return CustomCachedNetworkImage(
                      //         url: RepositoryProvider.of<CoOperative>(context)
                      //                 .baseUrl +
                      //             filteredItems[index].imageUrl.toString(),
                      //         fit: BoxFit.fitHeight);
                      //   },
                      //   itemCount: filteredItems.length,
                      // ),
                    ),
                  ),
                ),
                Positioned(
                  top: 600,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                    height: 50.hp,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // NavigationService.pushNamed(
                            //     routeName: Routes.myQrCode);
                          },
                          child: InkWell(
                            onTap: () {
                              NavigationService.pushReplacement(
                                  target: ShareQrPage());
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.qr_code,
                                    size: 22,
                                    color: _theme.primaryColor,
                                  ),
                                  SizedBox(width: 8.wp),
                                  Text(
                                    "Show my QR Code",
                                    style: _textTheme.bodyLarge!.copyWith(
                                      color: _theme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).viewPadding.top + 10,
                  left: CustomTheme.symmetricHozPadding,
                  child: CustomIconButton(
                    icon: Icons.close,
                    borderRadius: 15,
                    shadow: false,
                    onPressed: () {
                      NavigationService.pop();
                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }

  // void _onQRCodeDetect(
  //   Barcode barcode,
  //   MobileScannerArguments? args,
  // ) {
  //   _cameraSubscription = cameraController.barcodes.listen((code) {
  //     if (code.rawValue != null && _isScanned == false && mounted) {
  //       _isScanned = true;

  //       _processScannedQR(qrCode: code.rawValue ?? "");
  //     }
  //   });
  // }
  void _onQRCodeDetect(
    BarcodeCapture barcodeCapture,
  ) {
    _cameraSubscription = cameraController.barcodes.listen((code) {
      _cameraSubscription = cameraController.barcodes.listen((code) {
        final List _rawData = List.from(code.raw ?? []);
        if (_rawData.isNotEmpty) {
          final rawValue = _rawData.first["rawValue"];
          if (rawValue != null && _isScanned == false && mounted) {
            _isScanned = true;
            _processScannedQR(qrCode: rawValue ?? "");
          }
        }
      });
    });
  }

  _processScannedQR({
    required String qrCode,
  }) {
    print("QR Code debug: $qrCode");
    try {
      final Map<String, dynamic> _decode = jsonDecode(qrCode);
      print("QR Code debug 2: $_decode");

      WalletModel getWalletData(String walletName) {
        return widget.walletLists.firstWhere((element) =>
            element.name.toLowerCase().contains(walletName.toLowerCase()) &&
            element.status == "Active");
      }

      if (_decode.containsKey("eSewa_id")) {
        if (appServiceFilter(identifier: Slugs.loadWallet, state: appSeriveList)
                .status ==
            "Active") {
          final phoneNumber = _decode["eSewa_id"];
          NavigationService.pushReplacement(
            target: LoadWalletFormScreen(
              remarks: widget.remarks,
              phoneNumber: phoneNumber,
              selectedWallet: getWalletData("esewa"),
            ),
          );
        }
      }

      if (_decode.containsKey("service")) {
        if (appServiceFilter(identifier: Slugs.loadWallet, state: appSeriveList)
                .status ==
            "Active") {
          final phoneNumber = _decode["number"];
          NavigationService.pushReplacement(
              target: LoadWalletFormScreen(
            remarks: widget.remarks,
            phoneNumber: phoneNumber,
            selectedWallet: getWalletData("paywell"),
          ));
        }
      }
      if (_decode.containsKey("Khalti_ID")) {
        if (appServiceFilter(identifier: Slugs.loadWallet, state: appSeriveList)
                .status ==
            "Active") {
          final phoneNumber = _decode["Khalti_ID"];
          NavigationService.pushReplacement(
            target: LoadWalletFormScreen(
              remarks: widget.remarks,
              phoneNumber: phoneNumber,
              selectedWallet: getWalletData("khalti"),
            ),
          );
        }
      }
      // else {
      //   return NavigationService.pushReplacement(
      //       target: NoServiceScreen(
      //     data: appServiceFilter(
      //         identifier: Slugs.bankTransfer, state: appSeriveList),
      //   ));
      // }

      if (_decode.containsKey("bankCode")) {
        context.read<UtilityPaymentCubit>().fetchDetails(
            serviceIdentifier: "",
            accountDetails: {
              "pay_load": qrCode,
            },
            apiEndpoint: "api/qpay/merchant_detail");
      }
    } catch (e) {
      if (qrCode.toString().contains("fonepay.com")) {
        // if (appServiceFilter(identifier: Slugs.fonePay, state: appSeriveList)
        //         .status ==
        //     "Active") {
        NavigationService.pushReplacement(
            target: PayloadPage(
          remarks: widget.remarks,
          payload: qrCode,
        ));
        // } else {
        //   return NavigationService.pushReplacement(
        //       target: NoServiceScreen(
        //     data: appServiceFilter(
        //         identifier: Slugs.bankTransfer, state: appSeriveList),
        //   ));
        // }
      } else {
        NavigationService.popUntilFirstPage();
        NavigationService.push(
            target: EtellerPage(
          payload: qrCode,
          remarks: widget.remarks,
        ));
      }
    }

    @override
    void dispose() {
      animationController.dispose();
      cameraController.dispose();
      _cameraSubscription?.cancel();
      super.dispose();
    }
  }

  List<AppServiceManagementModel> appSeriveList = [
    AppServiceManagementModel(
        name: "Test",
        uniqueIdentifier: "test",
        type: "type",
        status: "Active",
        appOrder: 1,
        detailNew: true)
  ];
  AppServiceManagementModel appServiceFilter({
    required String identifier,
    required List<AppServiceManagementModel> state,
  }) {
    return state.firstWhere(
      (item) => item.uniqueIdentifier.toString() == identifier,
    );
  }
}

class NoServiceScreen extends StatelessWidget {
  final AppServiceManagementModel data;
  const NoServiceScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return const PageWrapper(
        showBackButton: true,
        body: NoDataScreen(
            title: "Service Unavailable",
            details: "Service is Currently Unavailable Please Contact Admin"));
  }
}
