import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/fingerprint_utils.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key, required this.onValueCallback})
      : super(key: key);
  final Function(bool) onValueCallback;

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);
  // bool switchValue = false;
  String mPin = "";
  @override
  void initState() {
    _checkBiometric();
    getMpin();
    super.initState();
  }

  getMpin() async {
    mPin = await SecureStorageService.appPassword;
    setState(() {});
  }

  _checkBiometric() async {
    final bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return Scaffold(
      body: PageWrapper(
        body: CommonContainer(
          showDetail: false,
          showTitleText: false,
          showRoundBotton: false,
          verticalPadding: 0,
          topbarName: "Biometric".tr(),
          body: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 40.hp,
                  ),
                  Text(
                    "Biometric Settings".tr(),
                    style: _textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30.hp,
                  ),
                  SvgPicture.asset(
                    Assets.fingerPrintImage,
                    height: 100,
                  ),
                  SizedBox(
                    height: 20.hp,
                  ),
                  Text(
                    "Enable/ Disable biometric login to login and payemnt without your MPIN."
                        .tr(),
                    style: _textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 30.hp,
                  ),
                  _isBiometricEnabled.value == true
                      ? CustomRoundedButtom(
                          title: "Disable Now".tr(),
                          onPressed: () async {
                            NavigationService.push(target: TransactionPinScreen(
                              onValueCallback: (p0) {
                                NavigationService.pop();
                                if (p0 == mPin) {
                                  SnackBarUtils.showSuccessBar(
                                    context: context,
                                    message: "Biometric Disable".tr(),
                                  );
                                  SharedPref.setBiometricLogin(false);
                                  setState(() {});
                                } else {
                                  SnackBarUtils.showErrorBar(
                                    context: context,
                                    message:
                                        "Pin doesnot match. Please try again."
                                            .tr(),
                                  );
                                }
                                NavigationService.pop();
                              },
                            ));
                          },
                        )
                      : CustomRoundedButtom(
                          title: "Enable Now".tr(),
                          onPressed: () async {
                            final bool _isFingerprintAvailable =
                                await FingerPrintUtils.hasFingerPrint;
                            if (_isFingerprintAvailable) {
                              widget.onValueCallback(
                                await FingerPrintUtils.verifyFingerPrint(
                                  context: context,
                                  reason: "Enable biometric login.".tr(),
                                ),
                              );
                              SharedPref.setBiometricLogin(true);
                              SnackBarUtils.showSuccessBar(
                                context: context,
                                message: "Biometric Enabled".tr(),
                              );
                              NavigationService.pop();
                              setState(() {});
                            }
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
//import 'package:flutter/material.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/shared_pref/shared_pref.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/util/snackbar_utils.dart';
// import 'package:ismart/common/widget/common_button.dart';
// import 'package:ismart/common/widget/common_container.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/authentication/ui/widgets/biometric_login_page.dart';

// class AuthenticationScreen extends StatefulWidget {
//   const AuthenticationScreen({Key? key}) : super(key: key);

//   @override
//   State<AuthenticationScreen> createState() => _AuthenticationScreenState();
// }

// class _AuthenticationScreenState extends State<AuthenticationScreen> {
//   final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);
//   // bool switchValue = false;

//   @override
//   void initState() {
//     _checkBiometric();

//     super.initState();
//   }

//   _checkBiometric() async {
//     final bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
//     if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
//       _isBiometricEnabled.value = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     return Scaffold(
//       body: PageWrapper(
//         body: CommonContainer(
//           showDetail: false,
//           showTitleText: false,
//           showRoundBotton: false,
//           verticalPadding: 0,
//           topbarName: "Biometric",
//           body: Column(
//             children: [
//               SizedBox(height: 40.hp),
//               const Text(
//                 "Biometrics Setting",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 20.hp),
//               const Text(
//                 'Enable biometrics for easy login and transaction.',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 16, color: CustomTheme.darkerBlack),
//               ),
//               SizedBox(height: 40.hp),
//               const Icon(
//                 Icons.fingerprint,
//                 size: 80,
//                 color: Colors.blue,
//               ),
//               SizedBox(height: 40.hp),
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(18),
//                     color: Theme.of(context).primaryColor.withOpacity(0.5)),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: ValueListenableBuilder(
//                             valueListenable: _isBiometricEnabled,
//                             builder: (context, val, child) {
//                               return CustomRoundedButtom(
//                                 title: "Enable",
//                                 onPressed: () {
//                                   print(
//                                       "Onchange Value : Biometrics: ${_isBiometricEnabled.value}");

//                                   if (_isBiometricEnabled.value == false) {
//                                     NavigationService.pushReplacement(
//                                       target: BiometricLoginPage(
//                                         onValueCallback: (p0) {
//                                           NavigationService.pop();
//                                           if (p0) {
//                                             _isBiometricEnabled.value = true;
//                                             SharedPref.setBiometricLogin(true);
//                                             SnackBarUtils.showSuccessBar(
//                                               context: context,
//                                               message: "Biometric Enable",
//                                             );
//                                           }
//                                         },
//                                       ),
//                                     );
//                                     setState(() {});
//                                   } else {
//                                     SnackBarUtils.showSuccessBar(
//                                       context: context,
//                                       message: "Biometric is Already Enable.",
//                                     );
//                                   }
//                                 },
//                                 borderColor: _isBiometricEnabled.value == false
//                                     ? _theme.primaryColor
//                                     : Colors.transparent,
//                                 color: _isBiometricEnabled.value == false
//                                     ? _theme.primaryColor
//                                     : Colors.transparent,
//                               );
//                             })),
//                     Expanded(
//                       child: ValueListenableBuilder(
//                         valueListenable: _isBiometricEnabled,
//                         builder: (context, val, child) {
//                           return CustomRoundedButtom(
//                             title: "Disable",
//                             borderColor: _isBiometricEnabled.value == true
//                                 ? _theme.primaryColor
//                                 : Colors.transparent,
//                             color: _isBiometricEnabled.value == true
//                                 ? _theme.primaryColor
//                                 : Colors.transparent,
//                             onPressed: () {
//                               print(
//                                   "Onchange Value : Biometrics: ${_isBiometricEnabled.value}");
//                               if (_isBiometricEnabled.value == true) {
//                                 _isBiometricEnabled.value = false;
//                                 SharedPref.setBiometricLogin(false);
//                                 SnackBarUtils.showSuccessBar(
//                                   context: context,
//                                   message: "Biometric Disable",
//                                 );
//                               } else {
//                                 SnackBarUtils.showSuccessBar(
//                                   context: context,
//                                   message:
//                                       "Biometric is already Disabled. Please enable biometric.",
//                                 );
//                               }
//                               setState(() {});
//                             },
//                           );
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
