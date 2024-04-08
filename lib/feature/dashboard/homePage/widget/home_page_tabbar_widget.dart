// import 'package:flutter/material.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/category_page.dart';
// import 'package:ismart/feature/favorite/listFavAccount/screen/list_fav_account_page.dart';
// import 'package:ismart/feature/graph/ui/screen/graph_page.dart';

// class HomePageTabbarWidget extends StatefulWidget {
//   @override
//   _HomePageTabbarWidgetState createState() => _HomePageTabbarWidgetState();
// }

// class _HomePageTabbarWidgetState extends State<HomePageTabbarWidget> {
//   int _currentPageIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CustomButtonTabBar(
//                 text: 'Instant Payments',
//                 isSelected: _currentPageIndex == 0,
//                 // onTap: () => _changePage(0),
//                 onTap: () {
//                   setState(() {
//                     _changePage(0);
//                   });
//                 },
//               ),
//               CustomButtonTabBar(
//                 text: 'Graph & Activities',
//                 isSelected: _currentPageIndex == 1,
//                 onTap: () {
//                   setState(() {
//                     _changePage(1);
//                   });
//                 },
//                 // onTap: () => _changePage(1),
//               ),
//               CustomButtonTabBar(
//                 text: 'Favorite',
//                 isSelected: _currentPageIndex == 2,
//                 onTap: () {
//                   setState(() {
//                     _changePage(2);
//                   });
//                 },
//               ),
//             ],
//           ),
//         ),
//         Stack(
//           children: <Widget>[
//             Offstage(
//               offstage: _currentPageIndex != 0,
//               child: const CategoryPage(
//                 showAllServices: false,
//               ),
//               // child: Container(
//               //   height: 150,
//               //   color: Colors.amber,
//               // ),
//             ),
//             Offstage(
//               offstage: _currentPageIndex != 1,
//               child: const GraphPage(),
//               // child: Container(
//               // height: 150,
//               // color: Colors.red,
//               // ),
//             ),
//             Offstage(
//               offstage: _currentPageIndex != 2,
//               child: ListFavAccountPage(),
//               // child: Container(
//               // height: 150,
//               // color: Colors.green,
//               // ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   void _changePage(int newIndex) {
//     if (newIndex >= 0 && newIndex <= 2) {
//       _currentPageIndex = newIndex;
//     }
//   }
// }

// class CustomButtonTabBar extends StatelessWidget {
//   final String text;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const CustomButtonTabBar({
//     required this.text,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.w600,
//             color: isSelected ? Colors.black : const Color(0xFF989898),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
        children: [
          const TabBar(
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
                const CategoryPage(
                  // scrollController: ScrollController(),
                  showAllServices: false,
                ),
                const GraphPage(),
                ListFavAccountPage(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
