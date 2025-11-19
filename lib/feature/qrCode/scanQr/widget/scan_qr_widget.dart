// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/common_button.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
// import 'package:ismart/feature/qrCode/scanQr/screen/qr_response_page.dart';
// import 'package:ismart/feature/qrCode/shareQr/screen/share_qr_page.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRScannerWidgets extends StatefulWidget {
//   const QRScannerWidgets({super.key});

//   @override
//   State<QRScannerWidgets> createState() => _QRScannerWidgetsState();
// }

// class _QRScannerWidgetsState extends State<QRScannerWidgets> {
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

//   var result;
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
//     final _height = SizeUtils.height;
//     Size size = MediaQuery.of(context).size;

//     return result != null
//         ? QrREsponsePage(
//             result: result!,
//           )
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
//                           Assets.qrCodeIcon,
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
//                         Image.asset(
//                           "assets/images/ismart_logo_only.png",
//                           height: _height * 0.2,
//                         ),

//                         SizedBox(height: size.height * 0.4),
//                         const Text(
//                           "Our Partners :",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontFamily: "popinmedium",
//                               fontSize: 14,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white),
//                         ),
//                         //TDOD need to service provider logo from api
//                         Image.asset(
//                           "assets/images/fonepay_payments_fatafat 1.png",
//                           height: size.height * 0.03,
//                         ),
//                         CustomRoundedButtom(
//                             title: "Show my QR Code",
//                             onPressed: () {
//                               NavigationService.pushReplacement(
//                                 target: const ShareQrPage(),
//                               );
//                             }),
//                         Image.asset(Assets.ismartSlogan,
//                             height: SizeUtils.height * 0.1),
//                         TextButton(
//                           onPressed: () {
//                             NavigationService.pushUntil(
//                                 target: const DashboardPage());
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
//     final scanArea = (MediaQuery.of(context).size.width < 400 ||
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
//   final Barcode result;
//   const ORresultScreen({super.key, required this.result});

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
//           result.code!.length.toString(),
//           style: Theme.of(context).textTheme.displayLarge,
//         ),
//       ),
//     );
//   }
// }
