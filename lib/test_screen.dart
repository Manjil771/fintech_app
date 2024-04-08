import 'package:flutter/material.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/category_page.dart';
import 'package:ismart/feature/favorite/listFavAccount/screen/list_fav_account_page.dart';
import 'package:ismart/feature/graph/ui/screen/graph_page.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomButtonTabBar(
                text: 'Instant Payments',
                isSelected: _currentPageIndex == 0,
                // onTap: () => _changePage(0),
                onTap: () {
                  setState(() {
                    _changePage(0);
                  });
                },
              ),
              CustomButtonTabBar(
                text: 'Graph & Activities',
                isSelected: _currentPageIndex == 1,
                onTap: () {
                  setState(() {
                    _changePage(1);
                  });
                },
                // onTap: () => _changePage(1),
              ),
              CustomButtonTabBar(
                text: 'Favorite',
                isSelected: _currentPageIndex == 2,
                onTap: () {
                  setState(() {
                    _changePage(2);
                  });
                },
              ),
            ],
          ),
        ),
        Stack(
          children: <Widget>[
            Offstage(
              offstage: _currentPageIndex != 0,
              child: const CategoryPage(
                showAllServices: false,
              ),
              // child: Container(
              //   height: 150,
              //   color: Colors.amber,
              // ),
            ),
            Offstage(
              offstage: _currentPageIndex != 1,
              child: const GraphPage(),
              // child: Container(
              // height: 150,
              // color: Colors.red,
              // ),
            ),
            Offstage(
              offstage: _currentPageIndex != 2,
              child: ListFavAccountPage(),
              // child: Container(
              // height: 150,
              // color: Colors.green,
              // ),
            ),
          ],
        ),
      ],
    );
  }

  void _changePage(int newIndex) {
    if (newIndex >= 0 && newIndex <= 2) {
      _currentPageIndex = newIndex;
    }
  }
}

class CustomButtonTabBar extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomButtonTabBar({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.black : const Color(0xFF989898),
          ),
        ),
      ),
    );
  }
}
