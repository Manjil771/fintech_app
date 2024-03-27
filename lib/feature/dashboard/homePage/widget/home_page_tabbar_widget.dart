import 'package:flutter/material.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/category_page.dart';
import 'package:ismart/feature/favorite/listFavAccount/screen/list_fav_account_page.dart';
import 'package:ismart/feature/graph/ui/screen/graph_page.dart';

class HomePageTabbarWidget extends StatelessWidget {
  const HomePageTabbarWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Column(
        children: const [
          TabBar(
            isScrollable: true,
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xFF989898),
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            indicatorColor: Colors.transparent,
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(text: "Instant Payments"),
              Tab(text: "Graph & Activities"),
              Tab(text: "Favorite"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                CategoryPage(
                  showAllServices: false,
                ),
                GraphPage(),
                ListFavAccountPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
