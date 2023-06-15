import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/fingerprint_utils.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/authentication/cubit/login_cubit.dart';
import 'package:ismart/feature/authentication/enum/login_response_value.dart';
import 'package:ismart/feature/authentication/ui/widgets/biometric_login_page.dart';
import 'package:ismart/feature/authentication/ui/widgets/otp_widget.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _hasExistingLoginSaved = ValueNotifier(false);

  String _existingPhoneNumber = "";
  bool _isLoading = false;

  bool _isBiometricLogin = false;
  _checkBiometric() async {
    bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }

    _existingPhoneNumber = await SecureStorageService.appPhoneNumber;
    _hasExistingLoginSaved.value = _existingPhoneNumber.isNotEmpty;
    _hasExistingLoginSaved.value = false;
  }
  // 9803435443
  // 70074

  String _getPhoneNumber() {
    if (phoneController.text.isNotEmpty) return phoneController.text;
    return _existingPhoneNumber;
  }

  @override
  void initState() {
    _checkBiometric();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = SizeUtils.height;
    final width = SizeUtils.width;
    final _theme = Theme.of(context);
    return PageWrapper(
      backgroundColor: CustomTheme.white,
      showAppBar: false,
      padding: EdgeInsets.zero,
      body: BlocListener<LoginCubit, CommonState>(
        listener: (context, state) async {
          if (state is CommonLoading && _isLoading == false) {
            _isLoading = true;
            showLoadingDialogBox(context);
          } else if (state is! CommonLoading && _isLoading) {
            _isLoading = false;
            NavigationService.pop();
          }

          if (state is CommonStateSuccess<LoginResponseValue>) {
            if (state.data == LoginResponseValue.Success) {
              if (!_isBiometricLogin) {
                SecureStorageService.setAppPhoneNumber(_getPhoneNumber());
                SecureStorageService.setAppPassword(
                  passwordController.text,
                );
              }
              _hasExistingLoginSaved.value = true;
              if (await FingerPrintUtils.hasFingerPrint & !_isBiometricLogin) {
                NavigationService.pushReplacement(
                  target: BiometricLoginPage(
                    onValueCallback: (p0) {
                      if (p0) {
                        SharedPref.setBiometricLogin(true);
                      }
                      NavigationService.pushReplacement(
                        target: const DashboardPage(),
                      );
                    },
                  ),
                );
              } else {
                NavigationService.pushReplacement(
                  target: const DashboardPage(),
                );
              }
            } else if (state.data == LoginResponseValue.OTPVerification) {
              NavigationService.push(
                target: OTPWidget(
                  onValueCallback: (val) {
                    context.read<LoginCubit>().loginUser(
                          username: phoneController.text,
                          password: passwordController.text,
                          otpCode: val,
                        );
                  },
                ),
              );
            }
          } else if (state is CommonError) {
            SnackBarUtils.showErrorBar(
              context: context,
              message: state.message,
            );
          }
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 100,
            ),
            const IsmartTopWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.hp),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.03),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "popinbold",
                        fontSize: 36,
                        // color: Color(cblack),
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    ValueListenableBuilder<bool>(
                        valueListenable: _hasExistingLoginSaved,
                        builder: (context, val, _) {
                          if (!val) {
                            return CustomTextField(
                              title: "Mobile Number",
                              hintText: "Mobile Number",
                              controller: phoneController,
                              validator: (value) =>
                                  FormValidator.validatePhoneNumber(value),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    SizedBox(height: height * 0.014),
                    CustomTextField(
                      title: "Security pin",
                      hintText: "Security pin",
                      controller: passwordController,
                      validator: (value) =>
                          FormValidator.validateFieldNotEmpty(value, "MPIN"),
                    ),
                    SizedBox(height: height * 0.014),
                    Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              // TODO navigate to forget password widget
                              // Get.to(() => const ForgetPassword());
                            },
                            child: Text(
                              "Forgot PIN ?",
                              style: TextStyle(color: _theme.primaryColor),
                            )),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            // TODO Navigate to Can't Login Page
                            // Get.to(() => const CantLogin());
                          },
                          child: Text(
                            "Can't Login ?",
                            style: TextStyle(color: _theme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.035),
                    CustomRoundedButtom(
                        title: "Login",
                        onPressed: () {
                          // if (_loginFormKey.currentState!.validate()) {
                          context.read<LoginCubit>().loginUser(
                                username: "9803435443", password: "53637",
                                //username: _getPhoneNumber(),
                                //password: passwordController.text,
                              );
                          //  }
                        }),
                    SizedBox(height: height * 0.014),
                    ValueListenableBuilder<bool>(
                        valueListenable: _isBiometricEnabled,
                        builder: (context, val, _) {
                          if (val) {
                            return InkWell(
                              onTap: () async {
                                bool authenticated =
                                    await FingerPrintUtils.verifyFingerPrint(
                                  context: NavigationService.context,
                                );
                                if (authenticated) {
                                  final String phone =
                                      await SecureStorageService.appPhoneNumber;
                                  final String password =
                                      await SecureStorageService.appPassword;
                                  _isBiometricLogin = true;
                                  print(_isBiometricLogin);
                                  if (phone.isNotEmpty && password.isNotEmpty) {
                                    context.read<LoginCubit>().loginUser(
                                          username: phone,
                                          password: password,
                                        );
                                  }
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.fingerprint,
                                    size: 35,
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Text(
                                    "User Biometric to Login",
                                    style: _theme.textTheme.labelMedium,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    SizedBox(height: height * 0.022),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.hp, vertical: 10.hp),
                      height: height * 0.13,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF010C80),
                              Color(0xFF1926B4),
                              Color(0xFF010C80),
                            ],
                            stops: [
                              0.1622,
                              0.9933,
                              1.0,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            transform: GradientRotation(90.79 *
                                3.14159 /
                                180), // Convert degrees to radians
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Image.asset(
                              "assets/digital-marketing-5250590-4385769 1.png"),
                          SizedBox(width: width * 0.1),
                          const Expanded(
                            child: Text(
                              "Place your Advertisement here",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "popinmedium",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    TextButton(
                      onPressed: () {
                        // TODO Discover Product Navigation
                        // Get.to(() => const DiscoverProduct());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Discover our Products",
                            style: TextStyle(
                                fontSize: 18, color: _theme.primaryColor),
                          ),
                          Icon(
                            CupertinoIcons.forward,
                            color: _theme.primaryColor,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),

      // body: Obx(
      //   () {
      //     if (authController.isLoading.value) {
      //       return Stack(
      //         children: [
      //           LoginWidgetDetail(context),
      //           Container(
      //               color: _theme.primaryColor.withOpacity(0.1),
      //               height: double.infinity,
      //               width: double.infinity,
      //               child: const Center(child: CircularProgressIndicator())),
      //         ],
      //       );
      //     } else {
      //       return LoginWidgetDetail(context);
      //     }
      //   },
      // ),
    );
  }

  // LoginWidgetDetail(context) {
  //   Size size = MediaQuery.of(context).size;
  //   return
  // }

  // buildBox(BuildContext context, name, controller, obsecure) {
  //   Size size = MediaQuery.of(context).size;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(name, style: _theme.textTheme.titleLarge),
  //       SizedBox(height: height * 0.014),
  //       TextFormField(
  //         controller: controller,
  //         textAlign: TextAlign.left,
  //         obscureText: obsecure,
  //         keyboardType: const TextInputType.numberWithOptions(),
  //         style: const TextStyle(color: Colors.black),
  //         decoration: InputDecoration(
  //           filled: true,
  //           fillColor: const Color(0xf3f3f3),
  //           enabledBorder: OutlineInputBorder(
  //               borderRadius: BorderRadius.circular(20),
  //               borderSide: const BorderSide(color: Colors.black12)),
  //           hintText: "XXXXXXXXXX",
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
