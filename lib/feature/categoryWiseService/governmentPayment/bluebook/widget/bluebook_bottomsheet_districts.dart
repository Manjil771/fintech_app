import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';
import '../../../../../common/navigation/navigation_service.dart';

class BluebookBottomsheetDistricts extends StatelessWidget {
  final Function(String name, String id) onPress;
  final String title;

  final List items;
  final bool isPickUplocation;
  final Color backgroundColor;
  final bool showTopDivider;
  final int titleTopPadding;
  final int titleBottomPadding;
  const BluebookBottomsheetDistricts({
    super.key,
    this.isPickUplocation = false,
    this.backgroundColor = CustomTheme.backgroundColor,
    this.showTopDivider = true,
    this.titleTopPadding = 16,
    this.titleBottomPadding = 20,
    this.title = "",
    required this.items,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return Container(
        padding: EdgeInsets.only(
          left: CustomTheme.symmetricHozPadding.wp,
          right: CustomTheme.symmetricHozPadding.wp,
          top: 24.hp,
          bottom: 5.hp,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showTopDivider)
              Container(
                height: 4,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: CustomTheme.gray,
                ),
              ),
            Container(
              padding: EdgeInsets.only(
                top: titleTopPadding.hp,
                bottom: titleBottomPadding.hp,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: _textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NavigationService.pop();
                    },
                    child: Row(
                      children: [
                        Text(
                          "Close",
                          style: _textTheme.titleSmall!
                              .copyWith(color: CustomTheme.googleColor),
                        ),
                        const Icon(
                          Icons.cancel_outlined,
                          size: 20,
                          color: CustomTheme.googleColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final districtName = !isPickUplocation
                        ? (item['district_name'] ?? '').toString()
                        : item.toString();
                    final districtId = !isPickUplocation
                        ? (item['id'] ?? '').toString()
                        : 'Test';
                    return InkWell(
                        onTap: () {
                          onPress(districtName, districtId);
                          NavigationService.pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _theme.primaryColor.withOpacity(0.05),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(18)),
                          ),
                          child: Center(
                            child: Text(
                              districtName,
                              style: _textTheme.titleLarge,
                            ),
                          ),
                        ));
                  }),
            ),
          ],
        ));
  }
}
