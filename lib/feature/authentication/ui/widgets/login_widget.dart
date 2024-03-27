import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/fingerprint_utils.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_carousel.dart';
import 'package:ismart/common/widget/custom_password_field.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/authentication/cubit/login_cubit.dart';
import 'package:ismart/feature/authentication/cubit/validate_co_op_cubit.dart';
import 'package:ismart/feature/authentication/enum/login_response_value.dart';
import 'package:ismart/feature/authentication/model/coop_value.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/authentication/ui/actiateAccount/screen/activate_account_page.dart';
import 'package:ismart/feature/authentication/ui/widgets/biometric_login_page.dart';
import 'package:ismart/feature/authentication/ui/widgets/common_box.dart';
import 'package:ismart/feature/authentication/ui/widgets/coop_select_widget.dart';
import 'package:ismart/feature/authentication/ui/widgets/otp_widget.dart';
import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';
import 'package:uuid/uuid.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final String _supportContact = "9801132218";

  ValueNotifier<LoginCoOpValue?> selectedCoop = ValueNotifier(null);
  String _currentUUID = "";
  List<String> _bannerImages = [];
  List<String> _defaultBannerImages = [];

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final ValueNotifier<bool> _hasExistingLoginSaved = ValueNotifier(false);

  String _existingPhoneNumber = "";
  bool _isLoading = false;

  bool _isBiometricLogin = false;

  Future<String> _getDeviceUUID() async {
    String? _deviceUUID = await SharedPref.getDeviceUUID();
    if (_deviceUUID == null || _deviceUUID.isEmpty) {
      _deviceUUID = const Uuid().v4();
      SharedPref.setDeviceUUID(_deviceUUID);
    }
    _currentUUID = _deviceUUID;
    return _deviceUUID;
  }

  _checkBiometric() async {
    bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }

    _existingPhoneNumber = await SecureStorageService.appPhoneNumber;
    _hasExistingLoginSaved.value = _existingPhoneNumber.isNotEmpty;
    if (Platform.isIOS) {
      _hasExistingLoginSaved.value = false;
    }
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
    _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
    _defaultBannerImages =
        RepositoryProvider.of<StartUpRepository>(context).defaultbanners;

    if (!kIsWeb) {
      if (Platform.isIOS) {
        _hasExistingLoginSaved.value = false;
      }
    }

    super.initState();
  }

  final TextEditingController _selectedCoopController = TextEditingController();
  bool agreedToTerms = true;
  String maskPhoneNumber(String number) {
    final String firstTwo = number.substring(0, 2);
    final String lastTwo = number.substring(number.length - 2);
    final String masked = firstTwo + "******" + lastTwo;

    return masked;
  }

  @override
  Widget build(BuildContext context) {
    final height = SizeUtils.height;
    final width = SizeUtils.width;
    final _theme = Theme.of(context);
    final List onTapFunction = [
      () {
        NavigationService.pushNamed(routeName: Routes.forgotPin);
      },
      () {
        NavigationService.push(target: const ActivateAccountPage());
      },
      () {
        miscallBanking();
      },
    ];
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
            await SharedPref.setDeviceUUID(_currentUUID);
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
                  onValueCallback: (val) async {
                    context.read<LoginCubit>().loginUser(
                          username: _getPhoneNumber(),
                          password: passwordController.text,
                          otpCode: val,
                          deviceUUID: await _getDeviceUUID(),
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
            SizedBox(height: height * 0.05),
            IsmartTopWidget(showSupportIcon: true, supportAction: supportSheet),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.hp),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.01),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "popinbold",
                        fontSize: 26,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    BlocConsumer<ValidateCoOpCubit, CommonState>(
                      listener: (context, state) async {
                        if (state is CommonDataFetchSuccess<LoginCoOpValue> &&
                            state.data.length == 1) {
                          _selectedCoopController.text = state.data.first.bank;
                          RepositoryProvider.of<UserRepository>(context)
                              .updateCoopValue(state.data.first);
                          await SharedPref.setLoginCoop(state.data.first);
                          await Future.delayed(
                                  const Duration(milliseconds: 100))
                              .then(
                            (value) => setState(() {}),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is CommonDataFetchSuccess<LoginCoOpValue> &&
                            state.data.length > 1) {
                          return CustomTextField(
                            title: "CoOperative",
                            hintText: "Select CoOperative",
                            readOnly: true,
                            controller: _selectedCoopController,
                            validator: (val) =>
                                FormValidator.validateFieldNotEmpty(
                                    val, "CoOperative"),
                            onTap: () {
                              NavigationService.push(
                                target: CoopSelectWidget(
                                  allCoops: state.data,
                                  selectedCoop: selectedCoop,
                                  onValueSelected: (val) async {
                                    _selectedCoopController.text = val.bank;
                                    RepositoryProvider.of<UserRepository>(
                                            context)
                                        .updateCoopValue(val);
                                    await SharedPref.setLoginCoop(val);
                                    await Future.delayed(
                                            const Duration(milliseconds: 100))
                                        .then(
                                      (value) => setState(() {}),
                                    );
                                  },
                                  // onBankSelected: (val) {
                                  //   NavigationService.pop();
                                  //   // internalBranch = val;
                                  //   // branchCode = val.branchCode;
                                  //   // _branchController.text = val.name;
                                  // },
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _hasExistingLoginSaved,
                      builder: (context, val, _) {
                        if (!val) {
                          return CustomTextField(
                            title: "Mobile Number",
                            hintText: "Mobile Number",
                            controller: phoneController,
                            textInputType: TextInputType.phone,
                            validator: (value) =>
                                FormValidator.validateFieldNotEmpty(
                                    value, "Phone Number"),
                            onChanged: (val) async {
                              if (FormValidator.validatePhoneNumber(val) ==
                                  null) {
                                final CoOperative currentCoop =
                                    RepositoryProvider.of<CoOperative>(context);
                                if (currentCoop.shouldValidateCooperative) {
                                  await context
                                      .read<ValidateCoOpCubit>()
                                      .validateCoOperative(username: val);
                                  Future.delayed(const Duration(seconds: 3))
                                      .then((value) {
                                    setState(() {});
                                  });
                                }
                              }
                            },
                          );
                        } else {
                          return CustomTextField(
                            title: "Mobile Number",
                            readOnly: true,
                            hintText: maskPhoneNumber(_existingPhoneNumber),
                            customHintTextStyle: true,
                          );
                        }
                      },
                    ),
                    SizedBox(height: height * 0.01),
                    CustomPasswordField(
                      title: "Security pin",
                      hintText: "Security pin",
                      controller: passwordController,
                      textInputType: TextInputType.number,
                      validator: (value) =>
                          FormValidator.validateFieldNotEmpty(value, "MPIN"),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: agreedToTerms,
                          activeColor: Colors.blue,
                          onChanged: (value) {
                            setState(() {
                              agreedToTerms = !agreedToTerms;
                            });
                          },
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: _makeUrlRequest,
                            child: RichText(
                              text: TextSpan(
                                style: _theme.textTheme.titleSmall,
                                children: const [
                                  TextSpan(text: "I have read & agree to "),
                                  TextSpan(
                                      text: "Terms & Conditions.",
                                      style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    CustomRoundedButtom(
                      title: "Login",
                      onPressed: () async {
                        if (_loginFormKey.currentState!.validate()) {
                          if (agreedToTerms) {
                            context.read<LoginCubit>().loginUser(
                                  username: _getPhoneNumber(),
                                  password: passwordController.text,
                                  deviceUUID: await _getDeviceUUID(),
                                );
                          } else {
                            SnackBarUtils.showErrorBar(
                                context: context,
                                message: "Please agree to terms & conditions");
                          }
                        }
                      },
                    ),
                    SizedBox(height: height * 0.01),
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
                                  if (agreedToTerms) {
                                    final String phone =
                                        await SecureStorageService
                                            .appPhoneNumber;
                                    final String password =
                                        await SecureStorageService.appPassword;
                                    _isBiometricLogin = true;

                                    if (phone.isNotEmpty &&
                                        password.isNotEmpty) {
                                      context.read<LoginCubit>().loginUser(
                                            username: phone,
                                            password: password,
                                            deviceUUID: await _getDeviceUUID(),
                                          );
                                    }
                                  }
                                } else {
                                  SnackBarUtils.showErrorBar(
                                      context: context,
                                      message:
                                          "Please agree to terms & conditions");
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
                    SizedBox(height: height * 0.014),
                    // // if (RepositoryProvider.of<CoOperative>(context)
                    // //         .clientCode !=
                    // //     "EHVNI7CZJ3")
                    // Row(
                    //   children: [
                    //     TextButton(
                    //         onPressed: () {
                    //           NavigationService.pushNamed(
                    //               routeName: Routes.forgotPin);
                    //         },
                    //         child: Text(
                    //           "Forgot PIN ?",
                    //           style: TextStyle(color: _theme.primaryColor),
                    //         )),
                    //     const Spacer(),
                    //     TextButton(
                    //       onPressed: () {
                    //         NavigationService.push(
                    //             target: const ActivateAccountPage());
                    //       },
                    //       child: Text(
                    //         "Activate Account",
                    //         style: TextStyle(color: _theme.primaryColor),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // if (RepositoryProvider.of<CoOperative>(context)
                    //         .clientCode ==
                    //     "EHVNI7CZJ3")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                            3,
                            (index) => CommonBox(
                                onContainerPress: onTapFunction[index],
                                containerImage: imageList[index],
                                title: nameList[index]))
                      ],
                    ),
                    SizedBox(height: height * 0.022),
                    if (_bannerImages.isNotEmpty)
                      CustomCarousel(
                        height: 140.hp,
                        topMargin: 10,
                        items: _bannerImages,
                      ),
                    if (_bannerImages.isEmpty &&
                        _defaultBannerImages.isNotEmpty)
                      CustomCarousel(
                        height: 140.hp,
                        topMargin: 10,
                        items: _defaultBannerImages,
                      ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final List nameList = [
    "Reset Pin",
    "Activate Account",
    "Missed Call Banking"
  ];
  final List imageList = [
    "assets/icons/Reset password.svg",
    "assets/icons/activate account.svg",
    "assets/icons/missedcall icon.svg",
  ];

  miscallBanking() {
    final _textTheme = Theme.of(NavigationService.context).textTheme;

    showModalBottomSheet(
      context: NavigationService.context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.hp),
          topRight: Radius.circular(30.hp),
        ),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 24),
              height: 4,
              width: 55,
              decoration: BoxDecoration(
                color: CustomTheme.lightGray.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              "Choose Option",
              style: _textTheme.labelLarge!.copyWith(
                color: CustomTheme.darkerBlack,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Divider(
              height: 40,
            ),
            ...List.generate(
              _miscallBankingOptions.length,
              (index) {
                return InkWell(
                  // onTap: _miscallBankingOptions[index]['action'] as Function(),
                  onTap: () async {
                    await UrlLauncher.launchPhone(
                        context: context, phone: _miscallBankingNumbers[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.hp,
                      vertical: 15.hp,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _miscallBankingOptions[index]['title'],
                                  style: _textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: CustomTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  _miscallBankingNumbers[index],
                                  style: _textTheme.bodyLarge!.copyWith(
                                    color: CustomTheme.darkGray,
                                  ),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: CustomTheme.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  supportSheet() {
    final _textTheme = Theme.of(NavigationService.context).textTheme;

    showModalBottomSheet(
      context: NavigationService.context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.hp),
          topRight: Radius.circular(30.hp),
        ),
      ),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24, bottom: 24),
              height: 4,
              width: 55,
              decoration: BoxDecoration(
                color: CustomTheme.lightGray.withOpacity(0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              "Choose Option",
              style: _textTheme.labelLarge!.copyWith(
                color: CustomTheme.darkerBlack,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const Divider(
              height: 40,
            ),
            ...List.generate(
              _supportOptions.length,
              (index) {
                return InkWell(
                  onTap: _supportOptions[index]['action'] as Function(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.hp,
                      vertical: 15.hp,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Call",
                                  style: _textTheme.bodyLarge!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: CustomTheme.primaryColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  contactNumberList[index],
                                  style: _textTheme.bodyLarge!.copyWith(
                                    color: CustomTheme.darkGray,
                                  ),
                                )
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: CustomTheme.primaryColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> _miscallBankingOptions = [
    {
      "title": "Topup",
      "action": () {
        NavigationService.pop();
      },
    },
    {
      "title": "Balance Inquiry",
      "action": () {
        NavigationService.pop();
      },
    },
    {
      "title": "Mini Statement",
      "action": () {
        NavigationService.pop();
      },
    },
  ];
  final List contactNumberList = ["9801132219", "9801132218"];

  final List<Map<String, dynamic>> _supportOptions = [
    {
      "title": "Call",
      "action": () async {
        await UrlLauncher.launchPhone(
            context: NavigationService.context, phone: "9801132219");
      },
    },
    {
      "title": "Call",
      "action": () async {
        await UrlLauncher.launchPhone(
            context: NavigationService.context, phone: "9801132218");
      },
    },
  ];

  Future<void> _makeUrlRequest() async {
    if (await UrlLauncher.launchWebsite(
        context: context,
        url: "https://devanasoft.com.np/PrivacyPolicy.html")) {}
  }

  final List _miscallBankingNumbers = [
    "9820499111",
    "9820499222",
    "9820488444",
  ];
}
