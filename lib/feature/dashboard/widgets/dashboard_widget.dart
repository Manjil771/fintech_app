import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/banking/screen/banking_page.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/screen/home_page.dart';
import 'package:ismart/feature/history/screen/recent_transaction_page.dart';
import 'package:ismart/feature/more/screen/more_page.dart';
import 'package:ismart/feature/qrCode/scanQr/screen/scan_qr_page.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  final ReceivePort _port = ReceivePort();
  int _currentIndex = 0;

  final screens = [
    const HomePage(),
    const Bankingpage(),
    const ScanQrPage(),
    const RecentTransactionScreen(),
    const MorePage()
  ];

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send([id, status, progress]);
    }
  }

  @override
  void initState() {
    _performStartupActions();
    context.read<CustomerDetailCubit>().fetchCustomerDetail();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  _performStartupActions() {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) async {
      final String downloadId = data[0];
      final DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      print(status);
      if (status == DownloadTaskStatus.enqueued) {
      } else if (status == DownloadTaskStatus.complete) {
        if (Platform.isIOS) {
          final _query = 'SELECT * FROM task WHERE task_id="$downloadId"';
          final List<DownloadTask> _downloadedTask =
              (await FlutterDownloader.loadTasksWithRawQuery(query: _query)) ??
                  [];
          String _filePath = "";
          if (_downloadedTask.isNotEmpty) {
            _filePath =
                "${_downloadedTask.first.savedDir}/${_downloadedTask.first.filename}";
          }
        }
        SnackBarUtils.showSuccessBar(
            context: context, message: "Download Completed.");
      } else if (status == DownloadTaskStatus.failed) {
        SnackBarUtils.showErrorBar(
            context: context, message: "Download Failed.");
      } else if (status == DownloadTaskStatus.canceled) {
        SnackBarUtils.showErrorBar(
            context: context, message: "Download Cancelled.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return PageWrapper(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => screens[_currentIndex],
      ),
      floatinActionButton: FloatingActionButton(
        backgroundColor: _theme.primaryColor,
        onPressed: () {
          NavigationService.push(target: const ScanQrPage());
        },
        child: SvgPicture.asset(
          Assets.qrCodeIcon,
          height: 30,
        ),
      ),
      bottomNavBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomTheme.white,
        selectedLabelStyle:
            const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
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
    );
  }
}
