import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/market/widget/market_place_homepage.dart';
import 'package:ismart/feature/market/widget/shopping_cart_widget.dart';

class MarketPlaceWidget extends StatefulWidget {
  const MarketPlaceWidget({super.key});

  @override
  State<MarketPlaceWidget> createState() => _MarketPlaceWidgetState();
}

class _MarketPlaceWidgetState extends State<MarketPlaceWidget> {
  int _currentIndex = 0;
  final screens = [MarketplaceHomePage(), const ShoppingCartWidget()];
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return PageWrapper(
      padding: const EdgeInsets.all(0),
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
              label: "Market"),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.marketPlaceIcon,
              height: 20,
              color: _currentIndex == 1
                  ? _theme.primaryColor
                  : CustomTheme.darkGray.withOpacity(0.5),
            ),
            label: "Cart",
          ),
        ],
      ),
      showBackButton: true,
      body: PageView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return screens[_currentIndex];
          }),
    );
  }
}
