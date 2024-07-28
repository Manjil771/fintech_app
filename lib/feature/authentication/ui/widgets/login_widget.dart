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
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/custom_carousel.dart';
import 'package:ismart/common/widget/custom_password_field.dart';
import 'package:ismart/common/widget/ismart_top_widget.dart';
import 'package:ismart/common/widget/login_common_text_field.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/feature/appContact/cubit/app_contact_cubit.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
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
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:uuid/uuid.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  String _selectedCountryCode = "977";
  String _selectedCountryValue = "np";
  bool showCountyCode = false;

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
    final bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
    if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
      _isBiometricEnabled.value = true;
    }

    _existingPhoneNumber = await SecureStorageService.appPhoneNumber;
    _hasExistingLoginSaved.value = _existingPhoneNumber.isNotEmpty;
  }

  String _getPhoneNumber() {
    if (phoneController.text.isNotEmpty) return phoneController.text;
    return _existingPhoneNumber;
  }

  List myBanners = [];
  @override
  void initState() {
    _checkBiometric();
    _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
    _defaultBannerImages =
        RepositoryProvider.of<StartUpRepository>(context).defaultbanners;
    getLoginStatus();
    super.initState();
  }

  final TextEditingController _selectedCoopController = TextEditingController();
  String maskPhoneNumber(String number) {
    final String firstTwo = number.substring(0, 2);
    final String lastTwo = number.substring(number.length - 2);
    final String masked = firstTwo + "******" + lastTwo;

    return masked;
  }

  getAppContactDetails() {
    return BlocBuilder<AppContactCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonStateSuccess<UtilityResponseData>) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  String loginStatus = "";
  bool rememberMe = false;
  getLoginStatus() async {
    loginStatus = await SecureStorageService.loginStatus;
    rememberMe = loginStatus.toString() == "true" ? true : false;
    setState(() {});
    return rememberMe;
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
            getAppContactDetails(),
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
                            title: "Cooperative",
                            hintText: "Select Cooperative",
                            readOnly: true,
                            controller: _selectedCoopController,
                            validator: (val) =>
                                FormValidator.validateFieldNotEmpty(
                                    val, "Cooperative"),
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
                        // if (!val) {
                        return LoginCustomTextField(
                          leading: countryFlagWidget(),
                          readOnly:
                              rememberMe && _existingPhoneNumber.isNotEmpty,
                          title: "Mobile Number",
                          customHintTextStyle:
                              rememberMe && _existingPhoneNumber.isNotEmpty,
                          hintText:
                              rememberMe && _existingPhoneNumber.isNotEmpty
                                  ? maskPhoneNumber(_existingPhoneNumber)
                                  : "Mobile Number",
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          onTap: () {
                            setState(() {
                              showCountyCode = true;
                            });
                          },
                          validator: (value) {
                            if (rememberMe == false)
                              FormValidator.validateFieldNotEmpty(
                                  value, "Phone Number");
                            return null;
                          },
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
                    ValueListenableBuilder<bool>(
                      valueListenable: _hasExistingLoginSaved,
                      builder: (context, val, _) {
                        return Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              activeColor: Colors.blue,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = !rememberMe;
                                });
                              },
                            ),
                            const Text("Remember Me"),
                          ],
                        );
                      },
                    ),
                    CustomRoundedButtom(
                      title: "Login",
                      onPressed: () async {
                        // showDatePickerBottomSheet(
                        //   context: context,
                        //   currentDate: DateTime.now(),
                        //   onChanged: (value) {
                            
                        //   },
                        //   maxDate: DateTime(2030),
                        //   minDate: DateTime.now(),
                          
                        // );
                        FocusManager.instance.primaryFocus?.unfocus();
                        SecureStorageService.setLoginStatus(
                            rememberMe.toString());
                        if (_loginFormKey.currentState!.validate()) {
                          context.read<LoginCubit>().loginUser(
                                username: _getPhoneNumber(),
                                password: passwordController.text,
                                deviceUUID: await _getDeviceUUID(),
                              );
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
                                final bool authenticated =
                                    await FingerPrintUtils.verifyFingerPrint(
                                  context: NavigationService.context,
                                );
                                if (authenticated) {
                                  final String phone =
                                      await SecureStorageService.appPhoneNumber;
                                  final String password =
                                      await SecureStorageService.appPassword;
                                  _isBiometricLogin = true;

                                  if (phone.isNotEmpty && password.isNotEmpty) {
                                    context.read<LoginCubit>().loginUser(
                                          username: phone,
                                          password: password,
                                          deviceUUID: await _getDeviceUUID(),
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
                    SizedBox(height: height * 0.014),
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
    final contactNumber =
        RepositoryProvider.of<AppContactRepository>(context).contactNumber;

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
            InkWell(
              onTap: () async {
                await UrlLauncher.launchPhone(
                    context: NavigationService.context, phone: contactNumber);
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
                              "Call",
                              style: _textTheme.bodyLarge!.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: CustomTheme.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              RepositoryProvider.of<AppContactRepository>(
                                      context)
                                  .contactNumber,
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

  countryFlagWidget() {
    final _theme = Theme.of(context);
    return BlocBuilder<UtilityPaymentCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final List countryCode = state.data.findValue(primaryKey: "data");

          return InkWell(
              child: Row(
                children: [
                  CustomCachedNetworkImage(
                    url:
                        "https://www.geonames.org/flags/x/$_selectedCountryValue.gif",
                    height: 20,
                    width: 30,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(width: 5.wp),
                  if (showCountyCode)
                    Text(
                      _selectedCountryCode,
                      style: _theme.textTheme.titleLarge,
                    ),
                  SizedBox(width: 5.wp),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Country'),
                      content: Container(
                        width: double.maxFinite,
                        height: 300,
                        child: ListView.builder(
                            itemCount: countryCode.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  _selectedCountryCode =
                                      countryCode[index]["dialCode"];
                                  _selectedCountryValue =
                                      countryCode[index]["isoTwo"];
                                  NavigationService.pop();
                                  setState(() {});
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Image.network(
                                          "https://www.geonames.org/flags/x/${countryCode[index]["isoTwo"].toString().toLowerCase()}.gif",
                                          height: 10,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          countryCode[index]["name"],
                                          style: _theme.textTheme.bodyLarge,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    );
                  },
                );
              });
        } else {
          return Container();
        }
      },
    );
  }
}

// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/route/routes.dart';
// import 'package:ismart/common/shared_pref/shared_pref.dart';
// import 'package:ismart/common/util/fingerprint_utils.dart';
// import 'package:ismart/common/util/form_validator.dart';
// import 'package:ismart/common/util/secure_storage_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/util/snackbar_utils.dart';
// import 'package:ismart/common/util/url_launcher.dart';
// import 'package:ismart/common/widget/common_button.dart';
// import 'package:ismart/common/widget/common_text_field.dart';
// import 'package:ismart/common/widget/custom_cached_network_image.dart';
// import 'package:ismart/common/widget/custom_carousel.dart';
// import 'package:ismart/common/widget/custom_password_field.dart';
// import 'package:ismart/common/widget/ismart_top_widget.dart';
// import 'package:ismart/common/widget/login_common_text_field.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_loading_dialog.dart';
// import 'package:ismart/feature/appContact/cubit/app_contact_cubit.dart';
// import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
// import 'package:ismart/feature/authentication/cubit/login_cubit.dart';
// import 'package:ismart/feature/authentication/cubit/validate_co_op_cubit.dart';
// import 'package:ismart/feature/authentication/enum/login_response_value.dart';
// import 'package:ismart/feature/authentication/model/coop_value.dart';
// import 'package:ismart/feature/authentication/resource/user_repository.dart';
// import 'package:ismart/feature/authentication/ui/actiateAccount/screen/activate_account_page.dart';
// import 'package:ismart/feature/authentication/ui/widgets/biometric_login_page.dart';
// import 'package:ismart/feature/authentication/ui/widgets/common_box.dart';
// import 'package:ismart/feature/authentication/ui/widgets/coop_select_widget.dart';
// import 'package:ismart/feature/authentication/ui/widgets/otp_widget.dart';
// import 'package:ismart/feature/dashboard/screen/dashboard_page.dart';
// import 'package:ismart/feature/splash/resource/startup_repository.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:uuid/uuid.dart';

// class LoginWidget extends StatefulWidget {
//   const LoginWidget({Key? key}) : super(key: key);

//   @override
//   State<LoginWidget> createState() => _LoginWidgetState();
// }

// class _LoginWidgetState extends State<LoginWidget> {
//   String _selectedCountryCode = "977";
//   String _selectedCountryValue = "np";
//   bool showCountyCode = false;

//   ValueNotifier<LoginCoOpValue?> selectedCoop = ValueNotifier(null);
//   String _currentUUID = "";
//   List<String> _bannerImages = [];
//   List<String> _defaultBannerImages = [];

//   final TextEditingController phoneController = TextEditingController();

//   final TextEditingController passwordController = TextEditingController();

//   final ValueNotifier<bool> _isBiometricEnabled = ValueNotifier(false);
//   final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

//   final ValueNotifier<bool> _hasExistingLoginSaved = ValueNotifier(false);

//   String _existingPhoneNumber = "";
//   bool _isLoading = false;

//   bool _isBiometricLogin = false;

//   Future<String> _getDeviceUUID() async {
//     String? _deviceUUID = await SharedPref.getDeviceUUID();
//     if (_deviceUUID == null || _deviceUUID.isEmpty) {
//       _deviceUUID = const Uuid().v4();
//       SharedPref.setDeviceUUID(_deviceUUID);
//     }
//     _currentUUID = _deviceUUID;
//     return _deviceUUID;
//   }

//   _checkBiometric() async {
//     final bool? isLocalBiometricEnabled = await SharedPref.getBiometricLogin();
//     if (isLocalBiometricEnabled != null && isLocalBiometricEnabled) {
//       _isBiometricEnabled.value = true;
//     }

//     _existingPhoneNumber = await SecureStorageService.appPhoneNumber;
//     _hasExistingLoginSaved.value = _existingPhoneNumber.isNotEmpty;
//     if (Platform.isIOS) {
//       _hasExistingLoginSaved.value = false;
//     }
//   }
//   // 9803435443
//   // 70074

//   String _getPhoneNumber() {
//     if (phoneController.text.isNotEmpty) return phoneController.text;
//     return _existingPhoneNumber;
//   }

//   List myBanners = [];
//   @override
//   void initState() {
//     _checkBiometric();
//     _bannerImages = RepositoryProvider.of<StartUpRepository>(context).banners;
//     _defaultBannerImages =
//         RepositoryProvider.of<StartUpRepository>(context).defaultbanners;

//     if (!kIsWeb) {
//       if (Platform.isIOS) {
//         _hasExistingLoginSaved.value = false;
//       }
//     }

//     super.initState();
//   }

//   final TextEditingController _selectedCoopController = TextEditingController();
//   bool agreedToTerms = true;
//   String maskPhoneNumber(String number) {
//     final String firstTwo = number.substring(0, 2);
//     final String lastTwo = number.substring(number.length - 2);
//     final String masked = firstTwo + "******" + lastTwo;

//     return masked;
//   }

//   getAppContactDetails() {
//     return BlocBuilder<AppContactCubit, CommonState>(
//       builder: (context, state) {
//         if (state is CommonStateSuccess<UtilityResponseData>) {
//           return Container();
//         } else {
//           return Container();
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = SizeUtils.height;
//     final width = SizeUtils.width;
//     final _theme = Theme.of(context);
//     final List onTapFunction = [
//       () {
//         NavigationService.pushNamed(routeName: Routes.forgotPin);
//       },
//       () {
//         NavigationService.push(target: const ActivateAccountPage());
//       },
//       () {
//         miscallBanking();
//       },
//     ];

//     return PageWrapper(
//       backgroundColor: CustomTheme.white,
//       showAppBar: false,
//       padding: EdgeInsets.zero,
//       body: BlocListener<LoginCubit, CommonState>(
//         listener: (context, state) async {
//           if (state is CommonLoading && _isLoading == false) {
//             _isLoading = true;
//             showLoadingDialogBox(context);
//           } else if (state is! CommonLoading && _isLoading) {
//             _isLoading = false;
//             NavigationService.pop();
//           }

//           if (state is CommonStateSuccess<LoginResponseValue>) {
//             await SharedPref.setDeviceUUID(_currentUUID);
//             if (state.data == LoginResponseValue.Success) {
//               if (!_isBiometricLogin) {
//                 SecureStorageService.setAppPhoneNumber(_getPhoneNumber());
//                 SecureStorageService.setAppPassword(
//                   passwordController.text,
//                 );
//               }
//               _hasExistingLoginSaved.value = true;
//               if (await FingerPrintUtils.hasFingerPrint & !_isBiometricLogin) {
//                 NavigationService.pushReplacement(
//                   target: BiometricLoginPage(
//                     onValueCallback: (p0) {
//                       if (p0) {
//                         SharedPref.setBiometricLogin(true);
//                       }
//                       NavigationService.pushReplacement(
//                         target: const DashboardPage(),
//                       );
//                     },
//                   ),
//                 );
//               } else {
//                 NavigationService.pushReplacement(
//                   target: const DashboardPage(),
//                 );
//               }
//             } else if (state.data == LoginResponseValue.OTPVerification) {
//               NavigationService.push(
//                 target: OTPWidget(
//                   onValueCallback: (val) async {
//                     context.read<LoginCubit>().loginUser(
//                           username: _getPhoneNumber(),
//                           password: passwordController.text,
//                           otpCode: val,
//                           deviceUUID: await _getDeviceUUID(),
//                         );
//                   },
//                 ),
//               );
//             }
//           } else if (state is CommonError) {
//             SnackBarUtils.showErrorBar(
//               context: context,
//               message: state.message,
//             );
//           }
//         },
//         child: ListView(
//           children: [
//             getAppContactDetails(),
//             SizedBox(height: height * 0.05),
//             IsmartTopWidget(showSupportIcon: true, supportAction: supportSheet),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.hp),
//               child: Form(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 key: _loginFormKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: height * 0.01),
//                     const Text(
//                       "Login",
//                       style: TextStyle(
//                         fontFamily: "popinbold",
//                         fontSize: 26,
//                         color: Colors.black,
//                       ),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     BlocConsumer<ValidateCoOpCubit, CommonState>(
//                       listener: (context, state) async {
//                         if (state is CommonDataFetchSuccess<LoginCoOpValue> &&
//                             state.data.length == 1) {
//                           _selectedCoopController.text = state.data.first.bank;
//                           RepositoryProvider.of<UserRepository>(context)
//                               .updateCoopValue(state.data.first);
//                           await SharedPref.setLoginCoop(state.data.first);
//                           await Future.delayed(
//                                   const Duration(milliseconds: 100))
//                               .then(
//                             (value) => setState(() {}),
//                           );
//                         }
//                       },
//                       builder: (context, state) {
//                         if (state is CommonDataFetchSuccess<LoginCoOpValue> &&
//                             state.data.length > 1) {
//                           return CustomTextField(
//                             title: "Cooperative",
//                             hintText: "Select Cooperative",
//                             readOnly: true,
//                             controller: _selectedCoopController,
//                             validator: (val) =>
//                                 FormValidator.validateFieldNotEmpty(
//                                     val, "Cooperative"),
//                             onTap: () {
//                               NavigationService.push(
//                                 target: CoopSelectWidget(
//                                   allCoops: state.data,
//                                   selectedCoop: selectedCoop,
//                                   onValueSelected: (val) async {
//                                     _selectedCoopController.text = val.bank;
//                                     RepositoryProvider.of<UserRepository>(
//                                             context)
//                                         .updateCoopValue(val);
//                                     await SharedPref.setLoginCoop(val);
//                                     await Future.delayed(
//                                             const Duration(milliseconds: 100))
//                                         .then(
//                                       (value) => setState(() {}),
//                                     );
//                                   },
//                                 ),
//                               );
//                             },
//                           );
//                         } else {
//                           return Container();
//                         }
//                       },
//                     ),
//                     ValueListenableBuilder<bool>(
//                       valueListenable: _hasExistingLoginSaved,
//                       builder: (context, val, _) {
//                         if (!val) {
//                           return LoginCustomTextField(
//                             leading:
//                                 BlocBuilder<UtilityPaymentCubit, CommonState>(
//                               builder: (context, state) {
//                                 if (state is CommonStateSuccess<
//                                     UtilityResponseData>) {
//                                   final List countryCode =
//                                       state.data.findValue(primaryKey: "data");

//                                   return InkWell(
//                                       child: Row(
//                                         children: [
//                                           CustomCachedNetworkImage(
//                                             url:
//                                                 "https://www.geonames.org/flags/x/$_selectedCountryValue.gif",
//                                             height: 20,
//                                             width: 30,
//                                             fit: BoxFit.fitHeight,
//                                           ),
//                                           SizedBox(width: 5.wp),
//                                           if (showCountyCode)
//                                             Text(
//                                               _selectedCountryCode,
//                                               style:
//                                                   _theme.textTheme.titleLarge,
//                                             ),
//                                           SizedBox(width: 5.wp),
//                                         ],
//                                       ),
//                                       onTap: () {
//                                         showDialog(
//                                           context: context,
//                                           builder: (BuildContext context) {
//                                             return AlertDialog(
//                                               title:
//                                                   const Text('Select Country'),
//                                               content: Container(
//                                                 width: double.maxFinite,
//                                                 height: 300,
//                                                 child: ListView.builder(
//                                                     itemCount:
//                                                         countryCode.length,
//                                                     itemBuilder:
//                                                         (context, index) {
//                                                       return InkWell(
//                                                         onTap: () {
//                                                           _selectedCountryCode =
//                                                               countryCode[index]
//                                                                   ["dialCode"];
//                                                           _selectedCountryValue =
//                                                               countryCode[index]
//                                                                   ["isoTwo"];
//                                                           NavigationService
//                                                               .pop();
//                                                           setState(() {});
//                                                         },
//                                                         child: Container(
//                                                           margin:
//                                                               const EdgeInsets
//                                                                   .symmetric(
//                                                                   vertical: 10),
//                                                           child: Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 flex: 1,
//                                                                 child: Image
//                                                                     .network(
//                                                                   "https://www.geonames.org/flags/x/${countryCode[index]["isoTwo"].toString().toLowerCase()}.gif",
//                                                                   height: 10,
//                                                                 ),
//                                                               ),
//                                                               Expanded(
//                                                                 flex: 3,
//                                                                 child: Text(
//                                                                   countryCode[
//                                                                           index]
//                                                                       ["name"],
//                                                                   style: _theme
//                                                                       .textTheme
//                                                                       .bodyLarge,
//                                                                 ),
//                                                               )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       );
//                                                     }),
//                                               ),
//                                             );
//                                           },
//                                         );
//                                       });
//                                 } else {
//                                   return Container();
//                                 }
//                               },
//                             ),
//                             title: "Mobile Number",
//                             hintText: "Mobile Number",
//                             controller: phoneController,
//                             textInputType: TextInputType.phone,
//                             onTap: () {
//                               setState(() {
//                                 showCountyCode = true;
//                               });
//                             },
//                             validator: (value) =>
//                                 FormValidator.validateFieldNotEmpty(
//                                     value, "Phone Number"),
//                             onChanged: (val) async {
//                               if (FormValidator.validatePhoneNumber(val) ==
//                                   null) {
//                                 final CoOperative currentCoop =
//                                     RepositoryProvider.of<CoOperative>(context);
//                                 if (currentCoop.shouldValidateCooperative) {
//                                   await context
//                                       .read<ValidateCoOpCubit>()
//                                       .validateCoOperative(username: val);
//                                   Future.delayed(const Duration(seconds: 3))
//                                       .then((value) {
//                                     setState(() {});
//                                   });
//                                 }
//                               }
//                             },
//                           );
//                         } else {
//                           return LoginCustomTextField(
//                             leading: Row(
//                               children: [
//                                 Image.network(
//                                   "https://www.geonames.org/flags/x/$_selectedCountryValue.gif",
//                                   height: 20,
//                                   width: 30,
//                                 ),
//                                 SizedBox(width: 5.wp),
//                               ],
//                             ),
//                             title: "Mobile Number",
//                             readOnly: true,
//                             hintText: maskPhoneNumber(_existingPhoneNumber),
//                             customHintTextStyle: true,
//                           );
//                         }
//                       },
//                     ),
//                     SizedBox(height: height * 0.01),
//                     CustomPasswordField(
//                       title: "Security pin",
//                       hintText: "Security pin",
//                       controller: passwordController,
//                       textInputType: TextInputType.number,
//                       validator: (value) =>
//                           FormValidator.validateFieldNotEmpty(value, "MPIN"),
//                     ),
//                     Row(
//                       children: [
//                         Checkbox(
//                           value: agreedToTerms,
//                           activeColor: Colors.blue,
//                           onChanged: (value) {
//                             setState(() {
//                               agreedToTerms = !agreedToTerms;
//                             });
//                           },
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             onTap: _makeUrlRequest,
//                             child: RichText(
//                               text: TextSpan(
//                                 style: _theme.textTheme.titleSmall,
//                                 children: const [
//                                   TextSpan(text: "I have read & agree to "),
//                                   TextSpan(
//                                       text: "Terms & Conditions.",
//                                       style: TextStyle(color: Colors.blue)),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     CustomRoundedButtom(
//                       title: "Login",
//                       onPressed: () async {
//                         FocusManager.instance.primaryFocus?.unfocus();

//                         if (_loginFormKey.currentState!.validate()) {
//                           // if (_selectedCountryValue.toString().toLowerCase() ==
//                           //     "np") {
//                           if (agreedToTerms) {
//                             context.read<LoginCubit>().loginUser(
//                                   username: _getPhoneNumber(),
//                                   password: passwordController.text,
//                                   deviceUUID: await _getDeviceUUID(),
//                                 );
//                           } else {
//                             SnackBarUtils.showErrorBar(
//                                 context: context,
//                                 message: "Please agree to terms & conditions");
//                           }
//                           // } else {
//                           //   SnackBarUtils.showErrorBar(
//                           //       context: context,
//                           //       message: "Invalid Mobile Number");
//                           // }
//                         }
//                       },
//                     ),
//                     SizedBox(height: height * 0.01),
//                     ValueListenableBuilder<bool>(
//                         valueListenable: _isBiometricEnabled,
//                         builder: (context, val, _) {
//                           if (val) {
//                             return InkWell(
//                               onTap: () async {
//                                 final bool authenticated =
//                                     await FingerPrintUtils.verifyFingerPrint(
//                                   context: NavigationService.context,
//                                 );
//                                 if (authenticated) {
//                                   if (agreedToTerms) {
//                                     final String phone =
//                                         await SecureStorageService
//                                             .appPhoneNumber;
//                                     final String password =
//                                         await SecureStorageService.appPassword;
//                                     _isBiometricLogin = true;

//                                     if (phone.isNotEmpty &&
//                                         password.isNotEmpty) {
//                                       context.read<LoginCubit>().loginUser(
//                                             username: phone,
//                                             password: password,
//                                             deviceUUID: await _getDeviceUUID(),
//                                           );
//                                     }
//                                   }
//                                 } else {
//                                   SnackBarUtils.showErrorBar(
//                                       context: context,
//                                       message:
//                                           "Please agree to terms & conditions");
//                                 }
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.fingerprint,
//                                     size: 35,
//                                   ),
//                                   SizedBox(
//                                     width: width * 0.03,
//                                   ),
//                                   Text(
//                                     "User Biometric to Login",
//                                     style: _theme.textTheme.labelMedium,
//                                   ),
//                                 ],
//                               ),
//                             );
//                           } else {
//                             return Container();
//                           }
//                         }),
//                     SizedBox(height: height * 0.014),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         ...List.generate(
//                             3,
//                             (index) => CommonBox(
//                                 onContainerPress: onTapFunction[index],
//                                 containerImage: imageList[index],
//                                 title: nameList[index]))
//                       ],
//                     ),
//                     SizedBox(height: height * 0.022),
//                     if (_bannerImages.isNotEmpty)
//                       CustomCarousel(
//                         height: 140.hp,
//                         topMargin: 10,
//                         items: _bannerImages,
//                       ),
//                     if (_bannerImages.isEmpty &&
//                         _defaultBannerImages.isNotEmpty)
//                       CustomCarousel(
//                         height: 140.hp,
//                         topMargin: 10,
//                         items: _defaultBannerImages,
//                       ),
//                     SizedBox(height: height * 0.02),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   final List nameList = [
//     "Reset Pin",
//     "Activate Account",
//     "Missed Call Banking"
//   ];
//   final List imageList = [
//     "assets/icons/Reset password.svg",
//     "assets/icons/activate account.svg",
//     "assets/icons/missedcall icon.svg",
//   ];

//   miscallBanking() {
//     final _textTheme = Theme.of(NavigationService.context).textTheme;

//     showModalBottomSheet(
//       context: NavigationService.context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30.hp),
//           topRight: Radius.circular(30.hp),
//         ),
//       ),
//       builder: (context) => Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(24),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 24, bottom: 24),
//               height: 4,
//               width: 55,
//               decoration: BoxDecoration(
//                 color: CustomTheme.lightGray.withOpacity(0.4),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             Text(
//               "Choose Option",
//               style: _textTheme.labelLarge!.copyWith(
//                 color: CustomTheme.darkerBlack,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const Divider(
//               height: 40,
//             ),
//             ...List.generate(
//               _miscallBankingOptions.length,
//               (index) {
//                 return InkWell(
//                   // onTap: _miscallBankingOptions[index]['action'] as Function(),
//                   onTap: () async {
//                     await UrlLauncher.launchPhone(
//                         context: context, phone: _miscallBankingNumbers[index]);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 15.hp,
//                       vertical: 15.hp,
//                     ),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   _miscallBankingOptions[index]['title'],
//                                   style: _textTheme.bodyLarge!.copyWith(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: CustomTheme.primaryColor,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 6,
//                                 ),
//                                 Text(
//                                   _miscallBankingNumbers[index],
//                                   style: _textTheme.bodyLarge!.copyWith(
//                                     color: CustomTheme.darkGray,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Icon(
//                               Icons.arrow_forward_ios,
//                               color: CustomTheme.primaryColor,
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   supportSheet() {
//     final _textTheme = Theme.of(NavigationService.context).textTheme;
//     final contactNumber =
//         RepositoryProvider.of<AppContactRepository>(context).contactNumber;

//     showModalBottomSheet(
//       context: NavigationService.context,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(30.hp),
//           topRight: Radius.circular(30.hp),
//         ),
//       ),
//       builder: (context) => Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(24),
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: const EdgeInsets.only(top: 24, bottom: 24),
//               height: 4,
//               width: 55,
//               decoration: BoxDecoration(
//                 color: CustomTheme.lightGray.withOpacity(0.4),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//             ),
//             Text(
//               "Choose Option",
//               style: _textTheme.labelLarge!.copyWith(
//                 color: CustomTheme.darkerBlack,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
//               ),
//             ),
//             const Divider(
//               height: 40,
//             ),
//             InkWell(
//               onTap: () async {
//                 await UrlLauncher.launchPhone(
//                     context: NavigationService.context, phone: contactNumber);
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 15.hp,
//                   vertical: 15.hp,
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Call",
//                               style: _textTheme.bodyLarge!.copyWith(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: CustomTheme.primaryColor,
//                               ),
//                             ),
//                             const SizedBox(height: 6),
//                             Text(
//                               RepositoryProvider.of<AppContactRepository>(
//                                       context)
//                                   .contactNumber,
//                               style: _textTheme.bodyLarge!.copyWith(
//                                 color: CustomTheme.darkGray,
//                               ),
//                             )
//                           ],
//                         ),
//                         Icon(
//                           Icons.arrow_forward_ios,
//                           color: CustomTheme.primaryColor,
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   final List<Map<String, dynamic>> _miscallBankingOptions = [
//     {
//       "title": "Topup",
//       "action": () {
//         NavigationService.pop();
//       },
//     },
//     {
//       "title": "Balance Inquiry",
//       "action": () {
//         NavigationService.pop();
//       },
//     },
//     {
//       "title": "Mini Statement",
//       "action": () {
//         NavigationService.pop();
//       },
//     },
//   ];

//   Future<void> _makeUrlRequest() async {
//     if (await UrlLauncher.launchWebsite(
//         context: context,
//         url: "https://devanasoft.com.np/PrivacyPolicy.html")) {}
//   }

//   final List _miscallBankingNumbers = [
//     "9820499111",
//     "9820499222",
//     "9820488444",
//   ];
// }
