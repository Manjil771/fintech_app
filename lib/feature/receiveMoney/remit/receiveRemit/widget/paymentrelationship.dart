import 'package:flutter/material.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_list_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';

class RelationshipListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> relationships;
  final Function(Map<String, dynamic>) onRelationshipSelected;

  const RelationshipListWidget({
    Key? key,
    required this.relationships,
    required this.onRelationshipSelected,
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
              child: Text("Relationships", style: _textTheme.displayLarge),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding,
              ),
              child: Text(
                "Select your relationship",
                style: _textTheme.titleLarge,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = relationships[index];
                print("Total relationships loaded: ${relationships.length}");
                return CustomListTile(
                  title: item['text'] ?? '',
                  description: item['value'] ?? '',
                  trailing: const SizedBox.shrink(),
                  imageUrl: "",
                  onPressed: () {
                    onRelationshipSelected(item);
                  },
                  horizontalPadding: CustomTheme.symmetricHozPadding,
                );
              },
              childCount: relationships.length,
            ),
          ),
        ],
      ),
    );
  }
}
