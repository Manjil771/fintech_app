import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/banking/screen/banking_page.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/dashboard/screen/home_page.dart';
import 'package:ismart/feature/statement/miniStatement/ui/screen/mini_statement_page.dart';

class DashBoardWidget extends StatefulWidget {
  const DashBoardWidget({Key? key}) : super(key: key);

  @override
  State<DashBoardWidget> createState() => _DashBoardWidgetState();
}

class _DashBoardWidgetState extends State<DashBoardWidget> {
  int _currentIndex = 0;

  final screens = [
    const HomePage(),
    const Bankingpage(),
    const Text("3"),
    MiniStatementPage(),
    const Text("5"),
  ];

  @override
  void initState() {
    context.read<CustomerDetailCubit>().fetchCustomerDetail();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return PageWrapper(
      body: PageView.builder(
        itemBuilder: (context, index) => screens[_currentIndex],
      ),
      floatinActionButton: FloatingActionButton(
        backgroundColor: _theme.primaryColor,
        onPressed: () {},
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
