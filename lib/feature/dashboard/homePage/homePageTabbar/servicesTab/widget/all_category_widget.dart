import 'package:flutter/material.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/screen/category_page.dart';

class AllCategoryWidget extends StatelessWidget {
  const AllCategoryWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        body: CommonContainer(
      horizontalPadding: 0,
      showRoundBotton: false,
      topbarName: "All Services",
      body: Container(
        child: const CategoryPage(
          showAllServices: true,
        ),
      ),
    ));
  }
}
