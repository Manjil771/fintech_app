import 'package:flutter/material.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/route/routes.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_gridview_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/allremittance_details_page.dart';
import 'package:ismart/feature/receiveMoney/remit/receiveRemit/screen/receive_remittance_page.dart';

class RemittancePage extends StatefulWidget {
  const RemittancePage({super.key});

  @override
  State<RemittancePage> createState() => _SelectHistoryOptionsState();
}

class _SelectHistoryOptionsState extends State<RemittancePage> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      body: CommonContainer(
        showDetail: false,
        topbarName: "Remittance",
        showTitleText: false,
        showRoundBotton: false,
        showBackBotton: true,
        body: Column(
          children: [
            Container(
              width: double.infinity,
              // height: _height * 0.7,
              child: Container(
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 2,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final option = remittanceOptions[index];
                        return CommonGridViewContainer(
                          onContainerPress: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => option['screen']),
                            );
                          },
                          margin: const EdgeInsets.all(8),
                          containerImage: option['image'],
                          title: option['title'],
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> remittanceOptions = [
    {
      'title': 'All Remittance',
      'image': Assets.remittanceIcon,
      // 'screen': const ReceiveRemittancePage(), // your actual widget
    },
    {
      'title': 'Remittance Transaction',
      'image': Assets.historyIcon,
      'screen': const (), // your actual widget
    },
  ];
}
