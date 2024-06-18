import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
import 'package:ismart/common/widget/custom_cached_network_image.dart';
import 'package:ismart/common/widget/custom_carousel.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/banking/screen/banking_page.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/dashboard/bannerImage/resource/banner_repository.dart';
import 'package:ismart/feature/dashboard/homePage/screen/home_page.dart';
import 'package:ismart/feature/history/screen/recent_transaction_page.dart';
import 'package:ismart/feature/more/screen/more_page.dart';
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
    const MorePage()
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
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 50),
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
                                  Icon(Icons.close_rounded,
                                      size: 20, color: CustomTheme.googleColor),
                                  SizedBox(
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
