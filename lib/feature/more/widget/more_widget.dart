import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
// import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
// import 'package:ismart/common/util/url_launcher.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/appContact/resources/app_contact_repository.dart';
import 'package:ismart/feature/more/authenticationScreen/biometric_screen.dart';
// import 'package:ismart/feature/more/calculator/calculator_screen.dart';
// import 'package:ismart/feature/more/feedback/screen/feedback_page.dart';
import 'package:ismart/feature/more/transactionLimit/transaction_limit_widget.dart';
import 'package:ismart/feature/profile/screen/profile_page.dart';
import 'package:ismart/feature/setting/changeMpin/screen/change_mpin_page.dart';
import 'package:ismart/feature/setting/screen/setting_page.dart';

String _supportContact =
    RepositoryProvider.of<AppContactRepository>(NavigationService.context)
        .contactNumber;

// List<Map<String, dynamic>> _contactUsOptions = [
//   {
//     "title": "Call Support",
//     "action": () {
//       // NavigationService.pop();
//       // UrlLauncher.launchPhone(
//       //   context: NavigationService.context,
//       //   phone: _supportContact,
//       // );
//     },
//   },
//   {
//     "title": "Chat on Viber",
//     "action": () {
//       NavigationService.pop();
//       UrlLauncher.launchWebsite(
//         context: NavigationService.context,
//         url: "viber://chat?number=%2B977$_supportContact",
//       );
//     },
//   },
//   {
//     "title": "Chat on WhatsApp",
//     "action": () {
//       NavigationService.pop();
//       UrlLauncher.launchUrlLink(
//         context: NavigationService.context,
//         url: "https://wa.me/%2B977$_supportContact",
//       );
//     },
//   },
// ];

// ignore: must_be_immutable
class MoreWidget extends StatefulWidget {
  const MoreWidget({Key? key}) : super(key: key);

  @override
  State<MoreWidget> createState() => _MoreWidgetState();
}

class _MoreWidgetState extends State<MoreWidget> {
  final List<String> itemImage = [
    Assets.accountInfo,
    Assets.fingerPrintImage,
    "assets/icons/pin-code-svgrepo-com 1.svg",
    Assets.transactionLimit,
    // Assets.discountCalculator,
    // Assets.downloadIcon,
    // Assets.contactUsIcon,
    Assets.settingIcon,
    // Assets.feedBackIcon
  ];

  String mPin = "";
  @override
  void initState() {
    getMpin();
    super.initState();
  }

  getMpin() async {
    mPin = await SecureStorageService.appPassword;
  }

  @override
  Widget build(BuildContext context) {
    context.locale;
    final List names = [
      LocaleKeys.accountInfo.tr(),
      LocaleKeys.biometric.tr(),
      LocaleKeys.changepin.tr(),
      LocaleKeys.transactionLimit.tr(),
      LocaleKeys.profileSetting.tr(),

      // "Calculator",
      // "Downloads",
      // "Support",
      // "Settings",
      // "FeedBack",
    ];
    final contactList = _supportContact.split(",");
    final List tapFunction = [
      () {
        NavigationService.push(
          target: const ProfilePage(),
        );
      },
      () {
        NavigationService.push(
            target: AuthenticationScreen(
          onValueCallback: (p0) {},
        ));
      },
      () {
        NavigationService.push(
            target: TransactionPinScreen(
          showBiometric: false,
          onValueCallback: (p0) {
            NavigationService.pop();

            if (p0 == mPin) {
              NavigationService.push(
                  target: ChangeMpinPage(
                oldMpin: p0,
              ));
            } else {
              print("mpin is $mPin");
              SnackBarUtils.showErrorBar(
                  context: NavigationService.context,
                  message: "Invalid Security Pin .Please try again.");
            }
          },
        ));
      },
      () {
        NavigationService.push(target: const TransactionLimitWidget());
      },
      // () {
      //   NavigationService.push(target: const CalculatorScreen());
      // },
      // () {
      //   NavigationService.pushNamed(routeName: Routes.downloadScreen);
      // },
      // () async {
      //   final _textTheme = Theme.of(NavigationService.context).textTheme;
      //   showModalBottomSheet(
      //     context: NavigationService.context,
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //         topLeft: Radius.circular(30.hp),
      //         topRight: Radius.circular(30.hp),
      //       ),
      //     ),
      //     builder: (context) => Container(
      //       decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.vertical(
      //           top: Radius.circular(24),
      //         ),
      //       ),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Container(
      //             margin: const EdgeInsets.only(top: 24, bottom: 24),
      //             height: 4,
      //             width: 55,
      //             decoration: BoxDecoration(
      //               color: CustomTheme.lightGray.withOpacity(0.4),
      //               borderRadius: BorderRadius.circular(4),
      //             ),
      //           ),
      //           Text(
      //             "Choose Option",
      //             style: _textTheme.labelLarge!.copyWith(
      //               color: CustomTheme.darkerBlack,
      //               fontWeight: FontWeight.bold,
      //               fontSize: 15,
      //             ),
      //           ),
      //           const Divider(
      //             height: 40,
      //           ),
      //           ...List.generate(
      //             contactList.length,
      //             (index) {
      //               return InkWell(
      //                 onTap: () {
      //                   NavigationService.pop();
      //                   UrlLauncher.launchPhone(
      //                     context: NavigationService.context,
      //                     phone: contactList[index],
      //                   );
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.symmetric(
      //                     horizontal: 15.hp,
      //                     vertical: 15.hp,
      //                   ),
      //                   child: Column(
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                         children: [
      //                           Column(
      //                             crossAxisAlignment: CrossAxisAlignment.start,
      //                             children: [
      //                               Text(
      //                                 "Call Support",
      //                                 style: _textTheme.bodyLarge!.copyWith(
      //                                   fontSize: 12,
      //                                   fontWeight: FontWeight.bold,
      //                                   color: CustomTheme.primaryColor,
      //                                 ),
      //                               ),
      //                               const SizedBox(height: 6),
      //                               Text(
      //                                 contactList[index],
      //                                 style: _textTheme.bodyLarge!.copyWith(
      //                                   color: CustomTheme.darkGray,
      //                                 ),
      //                               )
      //                             ],
      //                           ),
      //                           Icon(
      //                             Icons.arrow_forward_ios,
      //                             color: CustomTheme.primaryColor,
      //                           )
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             },
      //           ),
      //           const SizedBox(
      //             height: 30,
      //           ),
      //         ],
      //       ),
      //     ),
      //   );
      // },
      () {
        NavigationService.push(target: const SettingPage());
      },
      // () {
      //   NavigationService.push(target: const FeedBackPage());
      // },
    ];

    return CommonContainer(
      showTitleText: false,
      body: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: names.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return CommonGridViewContainer(
              onContainerPress: () => tapFunction[index](),
              containerImage: itemImage[index],
              title: names[index]);
        },
      ),
      topbarName: LocaleKeys.profile.tr(),
      showBackBotton: false,
      showDetail: false,
      showRoundBotton: false,
    );
  }
}
