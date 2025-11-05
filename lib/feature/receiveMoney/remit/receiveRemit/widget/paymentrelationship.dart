import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_list_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class SelectableListWidget extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final Function(Map<String, dynamic>) onItemSelected;

  const SelectableListWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;

    return PageWrapper(
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.hp)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              child: Text(title, style: _textTheme.displayLarge),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              child: Text(
                "Select your $title",
                style: _textTheme.titleLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = items[index];
                return CustomListTile(
                  title: item['text'] ?? '',
                  description: item['value'] ?? '',
                  trailing: const SizedBox.shrink(),
                  imageUrl: "",
                  onPressed: () {
                    onItemSelected(item);
                  },
                  horizontalPadding: CustomTheme.symmetricHozPadding,
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
