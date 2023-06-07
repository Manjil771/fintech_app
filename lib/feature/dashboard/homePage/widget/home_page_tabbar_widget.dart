import 'package:flutter/material.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/service_screen.dart';

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
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            indicatorColor: Colors.transparent,
            automaticIndicatorColorAdjustment: true,
            tabs: [
              Tab(text: "Payment"),
              Tab(text: "Graph & Activities"),
              Tab(text: "Favorite"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Center(
                  child: Text("Graph"),
                ),
                // ServicesPage(
                //   showAllServices: false,
                // ),
                Center(
                  child: Text("Graph"),
                ),
                Center(
                  child: Text("Favorite"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
