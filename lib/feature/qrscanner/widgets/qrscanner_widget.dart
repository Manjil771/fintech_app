import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/qr_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_icon_button.dart';
import 'package:ismart/common/widget/custom_shape_border.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/qrCode/shareQr/screen/share_qr_page.dart';
import 'package:ismart/feature/sendMoney/anyBank/screen/any_bank_page.dart';
import 'package:ismart/feature/sendMoney/anyBank/widgets/any_bank_widget.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/screens/load_wallet_form_screen.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../common/http/response.dart';

class QRScannerWidgets extends StatefulWidget {
  const QRScannerWidgets({
    Key? key,
  }) : super(key: key);

  @override
  State<QRScannerWidgets> createState() => _QRScannerWidgetsState();
}

class _QRScannerWidgetsState extends State<QRScannerWidgets>
    with SingleTickerProviderStateMixin {
  bool _isScanned = false;
  late AnimationController animationController;
  late Animation<double> _animation;
  final bool _isLoading = false;
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
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    final _qrSize = 200.wp;
    final _verticalMaxSize = (SizeUtils.height - _qrSize) / 2;
    final _horizontalMaxSize = (SizeUtils.width - _qrSize) / 2;
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
                          child: Image.asset(
                            "assets/images/ismart_inverted.jpeg",
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

          // Positioned(
          //   right: 0,
          //   left: 0,
          //   bottom: 90,
          //   child: Container(
          //     height: _verticalMaxSize,
          //     decoration: COlor,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           "assets/images/fonepay_payments_fatafat 1.png",
          //           height: 30.hp,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

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
            bottom: 0,
            child: Container(
              height: _verticalMaxSize,
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
                        NavigationService.push(target: ShareQrPage());
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
  }

  void _onQRCodeDetect(Barcode barcode, MobileScannerArguments? args) {
    _cameraSubscription = cameraController.barcodes.listen((code) {
      if (code.rawValue != null && _isScanned == false && mounted) {
        _isScanned = true;

        _processScannedQR(qrCode: code.rawValue ?? "");
      }
    });
  }

  _processScannedQR({required String qrCode}) {
    try {
      Map<String, dynamic> _decode = jsonDecode(qrCode);
      if (_decode.containsKey("eSewa_id")) {
        final phoneNumber = _decode["eSewa_id"];
        NavigationService.push(
            target: LoadWalletFormScreen(
                phoneNumber: phoneNumber,
                selectedWallet: WalletModel(
                    id: 11,
                    name: "eSewa",
                    descOneFieldName: "Wallet ID",
                    descOneFieldType: "String",
                    descOneFixedLength: true,
                    descOneLength: 10,
                    descOneMinLength: null,
                    descOneMaxLength: null,
                    descTwoFieldName: "Remarks",
                    descTwoFieldType: "String",
                    descTwoFixedLength: true,
                    descTwoLength: null ?? 0,
                    descTwoMinLength: null,
                    descTwoMaxLength: null,
                    icon:
                        "1687440159683b6770223-cf80-48e0-9856-f65a401c344a.png",
                    accountHead: "ESEWA",
                    accountNumber: "ESEWAWALLET",
                    minAmount: 10.00,
                    maxAmount: 25000.00,
                    status: "Active")));

        print("esewaaa");
      } else if (_decode.containsKey("bankCode")) {
        String _accountNumber = _decode['accountNumber'];
        String _accountName = _decode['accountName'];

        String _bankCode = _decode['bankCode'];
        NavigationService.push(
            target: AnyBankpage(
          accountNumber: _accountNumber,
          accountName: _accountName,
          bankCode: _bankCode,
        ));
        // TODO fonepay interbank qr
      } else if (_decode.containsKey("fonepay.com")) {
        String _accountNumber = _decode['account_number'];
        print("bank code selected");
        // TODO fonepay interbank qr
      }
    } catch (e) {
      // TODO Call backend for QR Code decoding
      // Esma feri error aayo backend bata vaney show error popup
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

// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/widget/common_button.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/dashboard/homePage/screen/home_page.dart';
// import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
// import 'package:ismart/feature/qrCode/shareQr/screen/share_qr_page.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class ScanQRWidget extends StatefulWidget {
//   const ScanQRWidget({super.key});

//   @override
//   State<ScanQRWidget> createState() => _ScanQRWidgetState();
// }

// class _ScanQRWidgetState extends State<ScanQRWidget> {
//   // Future<PermissionStatus> _getCameraPermission() async {
//   //   var status = await Permission.camera.status;
//   //   if (!status.isGranted) {
//   //     final result = await Permission.camera.request();
//   //     return result;
//   //   } else {
//   //     return status;
//   //   }
//   // }

//   @override
//   // void initState() {
//   //   _getCameraPermission();
//   //   super.initState();
//   // }

//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return result != null
//         ? const ORresultScreen()
//         : PageWrapper(
//             padding: EdgeInsets.zero,
//             body: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(18),
//                 color: Colors.white,
//               ),
//               child: Stack(
//                 children: [
//                   _buildQrView(context),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         SvgPicture.asset(
//                           "assets/icons/Group 913.svg",
//                           color: Colors.white,
//                           height: size.height * 0.04,
//                         ),
//                         const Text(
//                           "Scan QR Code",
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text("Put your phone still while scanning the OR code",
//                             textAlign: TextAlign.center,
//                             style: Theme.of(context).textTheme.titleSmall),
//                         SizedBox(height: size.height * 0.2),
//                         const Text(
//                           "Our Partners :",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontFamily: "popinmedium",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white),
//                         ),
//                         Image.asset(
//                           "assets/images/fonepay_payments_fatafat 1.png",
//                           height: size.height * 0.03,
//                         ),
//                         CustomRoundedButtom(
//                             title: "Show my QR Code",
//                             onPressed: () {
//                               NavigationService.push(target: ShareQrPage());
//                             }),
//                         TextButton(
//                           onPressed: () {
//                             NavigationService.pushUntil(
//                                 target: DashboardPage());
//                           },
//                           child: Text(
//                             "Cancel",
//                             style: TextStyle(
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }

//   Widget _buildQrView(BuildContext context) {
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 250.0
//         : 350.0;
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }

//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please allow camera permission')),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }

// class ORresultScreen extends StatelessWidget {
//   const ORresultScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Asd"),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//       ),
//       body: Center(
//         child: Text(
//           "QR Scanned",
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//       ),
//     );
//   }
// }
