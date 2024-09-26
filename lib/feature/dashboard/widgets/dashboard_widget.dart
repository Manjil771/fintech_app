// import 'dart:io';
// import 'dart:isolate';
// import 'dart:ui';

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ismart/app/theme.dart';
// import 'package:ismart/common/constant/assets.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/models/downloaded_file.dart';
// import 'package:ismart/common/navigation/navigation_service.dart';
// import 'package:ismart/common/shared_pref/shared_pref.dart';
// import 'package:ismart/common/util/notification_utils.dart';
// import 'package:ismart/common/util/permission_utils.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/common/widget/show_pop_up_dialog.dart';
// import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
// import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
// import 'package:ismart/feature/banking/screen/banking_page.dart';
// import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
// import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
// import 'package:ismart/feature/dashboard/homePage/screen/home_page.dart';
// import 'package:ismart/feature/history/screen/recent_transaction_page.dart';
// import 'package:ismart/feature/market/screen/market_place_screen.dart';
// import 'package:ismart/feature/more/screen/more_page.dart';
// import 'package:ismart/feature/qrscanner/screens/qrscanner_screen.dart';
// import 'package:ismart/test_screen.dart';
// import 'package:open_filex/open_filex.dart';
// import 'package:permission_handler/permission_handler.dart';

// class DashBoardWidget extends StatefulWidget {
//   const DashBoardWidget({Key? key}) : super(key: key);

//   @override
//   State<DashBoardWidget> createState() => _DashBoardWidgetState();
// }

// class _DashBoardWidgetState extends State<DashBoardWidget> {
//   final ReceivePort _port = ReceivePort();
//   int _currentIndex = 0;

//   final screens = [
//     const HomePage(),
//     const Bankingpage(),
//     const RecentTransactionScreen(),
//     const MorePage(),
//     TestPage(),
//   ];

//   @pragma('vm:entry-point')
//   static void downloadCallback(String id, int status, int progress) {
//     print("Download CallBack");
//     print(progress);
//     final SendPort? send =
//         IsolateNameServer.lookupPortByName('downloader_send_port');
//     if (send != null) {
//       send.send([id, status, progress]);
//     }
//   }

//   List<String> offerBanners = [];
//   @override
//   void initState() {
//     super.initState();
//     context
//         .read<CustomerDetailCubit>()
//         .fetchCustomerDetail(isCalledAtStatup: true);
//     if (!kIsWeb) {
//       _performStartupActions();
//       FlutterDownloader.registerCallback(downloadCallback);
//     }
//     offerBanners = RepositoryProvider.of<BannerRepository>(context).banners;
//     getAppService();
//   }

//   _performStartupActions() async {
//     // final permissionStatus = await Permission.storage.status;

//     // switch (permissionStatus) {
//     //   case PermissionStatus.denied:
//     //   case PermissionStatus.permanentlyDenied:
//     //     await Permission.storage.request();
//     //     break;
//     //   default:
//     // }
//     IsolateNameServer.registerPortWithName(
//         _port.sendPort, 'downloader_send_port');
//     _port.listen(
//       (dynamic data) async {
//         print("Download callback received");
//         print(data);
//         final String downloadId = data[0];
//         // final DownloadTaskStatus status = DownloadTaskStatus(data[1]);
//         final DownloadTaskStatus status =
//             DownloadTaskStatus.values[data[1] as int];

//         print(status);
//         if (status == DownloadTaskStatus.enqueued) {
//           NotificationUtils.generateDownloadingNotification();
//         } else if (status == DownloadTaskStatus.complete) {
//           String _filePath = "";
//           // if (Platform.isIOS) {
//           final _query = 'SELECT * FROM task WHERE task_id="$downloadId"';
//           final List<DownloadTask> _downloadedTask =
//               (await FlutterDownloader.loadTasksWithRawQuery(query: _query)) ??
//                   [];

//           if (_downloadedTask.isNotEmpty) {
//             _filePath =
//                 "${_downloadedTask.first.savedDir}/${_downloadedTask.first.filename}";
//             final DownloadedFile _downloadedFile = DownloadedFile(
//               fileName: _downloadedTask.first.filename ?? "",
//               filePath: _filePath,
//               downloadedDate: DateTime.now(),
//             );
//             await SharedPref.addDownloadedFiles(_downloadedFile);
//             await OpenFilex.open(_filePath);
//           }
//           NotificationUtils.generateDownloadCompletedNotification(_filePath);
//           // } else {
//           // OpenFile.open(_filePath);
//           // }
//         } else if (status == DownloadTaskStatus.failed) {
//           NotificationUtils.generateDownloadFailedNotification();
//         } else if (status == DownloadTaskStatus.canceled) {
//           NotificationUtils.generateDownloadCancelledNotification();
//         }
//       },
//     );
//   }

//   List<AppServiceManagementModel> appService = [];

//   getAppService() async {
//     final appServiceRepo = RepositoryProvider.of<AppServiceRepository>(context);
//     final response = await appServiceRepo.getAppService();
//     setState(() {
//       appService = appServiceRepo.appService;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppServiceManagementModel checkForMarketPlace() {
//       final item = appService.firstWhere(
//           (element) => element.uniqueIdentifier.toString() == "market_place");
//       return item;
//     }

//     final _theme = Theme.of(context);
//     return WillPopScope(
//         onWillPop: () {
//           showPopUpDialog(
//             context: context,
//             message: "Are you sure you want to exit ?",
//             title: "Logout",
//             buttonCallback: () {
//               SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//               exit(0);
//             },
//             buttonText: "Yes",
//             showCancelButton: true,
//           );

//           return Future.value(true);
//         },
//         child: Scaffold(
//           body: PageWrapper(body: screens[_currentIndex]),
//           bottomNavigationBar: Container(
//             height: 70.hp,
//             decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(8), topRight: Radius.circular(8))),
//             child: BottomAppBar(
//               padding: EdgeInsets.zero,
//               shape: const CircularNotchedRectangle(),
//               notchMargin: 8,
//               child: Container(
//                 // ignore: prefer_const_constructors
//                 decoration: BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       spreadRadius: 0.1,
//                       blurRadius: 5,
//                       offset: const Offset(0, -5),
//                     ),
//                   ],
//                   color: Colors.white,
//                 ),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: BottomMenu(
//                               title: "Home",
//                               onTap: () => setState(() => _currentIndex = 0),
//                               image: Assets.homeIcon,
//                               isSelected: _currentIndex == 0 ? true : false,
//                             ),
//                           ),
//                           Expanded(
//                             child: BottomMenu(
//                               title: "Banking",
//                               onTap: () => setState(() => _currentIndex = 1),
//                               image: Assets.bankingIcon,
//                               isSelected: _currentIndex == 1 ? true : false,
//                             ),
//                           ),
//                           Expanded(
//                             child: BottomMenu(
//                               title: "History",
//                               onTap: () => setState(() => _currentIndex = 2),
//                               image: Assets.historyIcon,
//                               isSelected: _currentIndex == 2 ? true : false,
//                             ),
//                           ),
//                           if (appService.isNotEmpty)
//                             if (checkForMarketPlace()
//                                     .status
//                                     .toString()
//                                     .toLowerCase() ==
//                                 "active")
//                               Expanded(
//                                 child: InkWell(
//                                   onTap: () => NavigationService.push(
//                                       target: const MarketPlaceScreen()),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       SizedBox(height: 5.hp),
//                                       Expanded(
//                                         child: SvgPicture.network(
//                                             "${RepositoryProvider.of<CoOperative>(context).baseUrl}${checkForMarketPlace().imageUrl}",
//                                             placeholderBuilder: (context) =>
//                                                 SvgPicture.asset(
//                                                   Assets.marketPlaceIcon,
//                                                   height: 25.hp,
//                                                 ),
//                                             height: 25.hp,
//                                             color: CustomTheme.darkGray
//                                                 .withOpacity(0.5)),
//                                       ),
//                                       Expanded(
//                                           child: Text(
//                                         checkForMarketPlace().name,
//                                         style: TextStyle(
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.bold,
//                                             color: CustomTheme.darkGray
//                                                 .withOpacity(0.5)),
//                                       ))
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                           Expanded(
//                             child: BottomMenu(
//                               title: "More",
//                               onTap: () => setState(() => _currentIndex = 3),
//                               image: Assets.moreIcon,
//                               isSelected: _currentIndex == 3 ? true : false,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(width: 70.wp),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           floatingActionButton: InkWell(
//             onTap: () async {
//               final _cameraPermission =
//                   await PermissionUtils.isCameraPermissionAvailable;
//               if (_cameraPermission) {
//                 NavigationService.push(target: const QRScannerScreens());
//               } else {
//                 showPopUpDialog(
//                   context: context,
//                   message:
//                       "We need camera permission to use QR Payment. You will be redirected to App Settings where you can enable the permission.",
//                   title: "Permission Denied",
//                   buttonCallback: () {
//                     openAppSettings();
//                   },
//                   showCancelButton: true,
//                 );
//               }
//             },
//             child: CircleAvatar(
//               radius: 30,
//               backgroundColor: CustomTheme.primaryColor,
//               child: SvgPicture.asset(
//                 Assets.qrCodeIcon,
//                 height: 30,
//                 color: CustomTheme.white,
//               ),
//             ),
//           ),
//           floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//         ));
//   }
// }

// class BottomMenu extends StatelessWidget {
//   final String image;
//   final Function() onTap;
//   final String title;

//   final bool isSelected;

//   const BottomMenu({
//     super.key,
//     required this.image,
//     required this.isSelected,
//     required this.onTap,
//     required this.title,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SizedBox(height: 5.hp),
//           Expanded(
//             child: SvgPicture.asset(image,
//                 height: isSelected ? 25.hp : 20.hp,
//                 color: isSelected == true
//                     ? CustomTheme.primaryColor
//                     : CustomTheme.darkGray.withOpacity(0.5)),
//           ),
//           Expanded(
//               child: Text(
//             title,
//             style: TextStyle(
//                 fontSize: isSelected ? 12 : 10,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.bold,
//                 color: isSelected
//                     ? CustomTheme.primaryColor
//                     : CustomTheme.darkGray.withOpacity(0.5)),
//           ))
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/models/downloaded_file.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/shared_pref/shared_pref.dart';
import 'package:ismart/common/util/notification_utils.dart';
import 'package:ismart/common/util/permission_utils.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/banking/screen/banking_page.dart';
import 'package:ismart/feature/categoryWiseService/movie/widget/count_down_movie_widget.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
import 'package:ismart/feature/dashboard/homePage/screen/home_page.dart';
import 'package:ismart/feature/history/screen/recent_transaction_page.dart';
import 'package:ismart/feature/qrscanner/screens/qrscanner_screen.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  final ReceivePort _port = ReceivePort();
  int _currentIndex = 0;
  final ValueNotifier<int> _currentSliderIndex = ValueNotifier(0);

  final screens = [
    const HomePage(),
    const Bankingpage(),
    const QRScannerScreens(),
    const RecentTransactionScreen(),
    // const MorePage()
    const TimerScreen(
      minutes: 10,
    ),
  ];

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    print("Download CallBack");
    print(progress);
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send([id, status, progress]);
    }
  }

  List<String> offerBanners = [];
  @override
  void initState() {
    super.initState();
    context
        .read<CustomerDetailCubit>()
        .fetchCustomerDetail(isCalledAtStatup: true);
    if (!kIsWeb) {
      _performStartupActions();
      FlutterDownloader.registerCallback(downloadCallback);
    }
    offerBanners = RepositoryProvider.of<BannerRepository>(context).banners;
  }

  _performStartupActions() async {
    // final permissionStatus = await Permission.storage.status;

    // switch (permissionStatus) {
    //   case PermissionStatus.denied:
    //   case PermissionStatus.permanentlyDenied:
    //     await Permission.storage.request();
    //     break;
    //   default:
    // }
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen(
      (dynamic data) async {
        print("Download callback received");
        print(data);
        final String downloadId = data[0];
        // final DownloadTaskStatus status = DownloadTaskStatus(data[1]);
        final DownloadTaskStatus status =
            DownloadTaskStatus.values[data[1] as int];

        print(status);
        if (status == DownloadTaskStatus.enqueued) {
          NotificationUtils.generateDownloadingNotification();
        } else if (status == DownloadTaskStatus.complete) {
          String _filePath = "";
          // if (Platform.isIOS) {
          final _query = 'SELECT * FROM task WHERE task_id="$downloadId"';
          final List<DownloadTask> _downloadedTask =
              (await FlutterDownloader.loadTasksWithRawQuery(query: _query)) ??
                  [];

          if (_downloadedTask.isNotEmpty) {
            _filePath =
                "${_downloadedTask.first.savedDir}/${_downloadedTask.first.filename}";
            final DownloadedFile _downloadedFile = DownloadedFile(
              fileName: _downloadedTask.first.filename ?? "",
              filePath: _filePath,
              downloadedDate: DateTime.now(),
            );
            await SharedPref.addDownloadedFiles(_downloadedFile);
            await OpenFilex.open(_filePath);
          }
          NotificationUtils.generateDownloadCompletedNotification(_filePath);
          // } else {
          // OpenFile.open(_filePath);
          // }
        } else if (status == DownloadTaskStatus.failed) {
          NotificationUtils.generateDownloadFailedNotification();
        } else if (status == DownloadTaskStatus.canceled) {
          NotificationUtils.generateDownloadCancelledNotification();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Stack(
      children: [
        _currentIndex == 2
            ? const QRScannerScreens()
            : WillPopScope(
                onWillPop: () {
                  showPopUpDialog(
                    context: context,
                    message: "Are you sure you want to exit ?",
                    title: "Logout",
                    buttonCallback: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                      exit(0);
                    },
                    buttonText: "Yes",
                    showCancelButton: true,
                  );

                  return Future.value(true);
                },
                child: PageWrapper(
                  body: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return screens[_currentIndex];
                      }),
                  floatinActionButton: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: FloatingActionButton(
                      backgroundColor: _theme.primaryColor,
                      onPressed: () async {
                        final _cameraPermission =
                            await PermissionUtils.isCameraPermissionAvailable;
                        if (_cameraPermission) {
                          NavigationService.push(
                              target: const QRScannerScreens());
                        } else {
                          showPopUpDialog(
                            context: context,
                            message:
                                "We need camera permission to use QR Payment. You will be redirected to App Settings where you can enable the permission.",
                            title: "Permission Denied",
                            buttonCallback: () {
                              openAppSettings();
                            },
                            showCancelButton: true,
                          );
                          // SnackBarUtils.showErrorBar(
                          //   context: context,
                          //   message: "Please allow camera permission to use Scan QR",
                          // );
                        }
                      },
                      child: SvgPicture.asset(
                        Assets.qrCodeIcon,
                        height: 30,
                      ),
                    ),
                  ),
                  bottomNavBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: CustomTheme.white,
                    selectedLabelStyle: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        TextStyle(color: CustomTheme.darkGray.withOpacity(0.5)),
                    selectedItemColor: Theme.of(context).primaryColor,
                    showUnselectedLabels: true,
                    currentIndex: _currentIndex,
                    onTap: (index) => setState(() {
                      _currentIndex = index;
                    }),
                    items: [
                      BottomNavigationBarItem(
                          icon: SvgPicture.asset(
                            Assets.homeIcon,
                            height: 20,
                            color: _currentIndex == 0
                                ? _theme.primaryColor
                                : CustomTheme.darkGray.withOpacity(0.5),
                          ),
                          label: 'Home'),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.bankingIcon,
                          height: 20,
                          color: _currentIndex == 1
                              ? _theme.primaryColor
                              : CustomTheme.darkGray.withOpacity(0.5),
                        ),
                        label: 'Banking',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.bankingIcon,
                          height: 25,
                          color: CustomTheme.white,
                        ),
                        label: 'Scan QR',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.historyIcon,
                          height: 20,
                          color: _currentIndex == 3
                              ? _theme.primaryColor
                              : CustomTheme.darkGray.withOpacity(0.5),
                        ),
                        label: 'History',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          Assets.moreIcon,
                          height: 20,
                          color: _currentIndex == 4
                              ? _theme.primaryColor
                              : CustomTheme.darkGray.withOpacity(0.5),
                        ),
                        label: 'More',
                      ),
                      // BottomNavigationBarItem(
                      //   icon: SvgPicture.asset(
                      //     Assets.moreIcon,
                      //     height: 20,
                      //     color: _currentIndex == 4
                      //         ? _theme.primaryColor
                      //         : CustomTheme.darkGray.withOpacity(0.5),
                      //   ),
                      //   label: 'More',
                      // ),
                    ],
                  ),
                ),
              ),
        if (offerBanners.isNotEmpty)
          GestureDetector(
            onTap: () {
              setState(() {
                offerBanners.clear(); // Example to clear the banners
              });
            },
            child: SafeArea(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 50),
                    alignment: Alignment.center,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 30.hp),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  offerBanners
                                      .clear(); // Example to clear the banners
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Close",
                                    style: _theme.textTheme.bodyLarge!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: CustomTheme.white),
                                  ),
                                  const Icon(Icons.close_rounded,
                                      size: 20, color: CustomTheme.googleColor),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              )),
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlayInterval: const Duration(seconds: 5),
                              autoPlay: offerBanners.length > 1 ? true : false,
                              initialPage: 0,
                              onPageChanged: (index, _) {
                                _currentSliderIndex.value = index;
                              },
                              viewportFraction: 0.95,
                              aspectRatio: 1 / 1.414,
                              enlargeCenterPage: true,
                            ),
                            items: List.generate(offerBanners.length, (index) {
                              return InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Image.network(
                                    offerBanners[index],
                                    width: double.infinity,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) => Column(
                                      children: [
                                        Image.asset(
                                            RepositoryProvider.of<CoOperative>(
                                                    context)
                                                .coOperativeLogo),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    )),
              ),
            ),
          ),
      ],
    );
  }
}
