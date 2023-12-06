import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/custom_list_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/authentication/model/coop_value.dart';

class CoopSelectWidget extends StatefulWidget {
  const CoopSelectWidget({
    Key? key,
    required this.allCoops,
    required this.selectedCoop,
    required this.onValueSelected,
  }) : super(key: key);
  final List<LoginCoOpValue> allCoops;
  final ValueNotifier<LoginCoOpValue?> selectedCoop;
  final Function(LoginCoOpValue) onValueSelected;
  @override
  State<CoopSelectWidget> createState() => _CoopSelectWidgetState();
}

class _CoopSelectWidgetState extends State<CoopSelectWidget> {
  final bool _showTitleAndDesc = true;

  @override
  void initState() {
    super.initState();
  }

  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      padding: EdgeInsets.zero,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 15.hp)),
          if (_showTitleAndDesc)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                child: Text(
                  "Co-Operative",
                  style: _textTheme.displayLarge,
                ),
              ),
            ),
          if (_showTitleAndDesc)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding,
                ),
                child: Text(
                  "Select Co-Operative",
                  style: _textTheme.titleLarge,
                ),
              ),
            ),
          if (_showTitleAndDesc)
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                String _baseUrl = RepositoryProvider.of<CoOperative>(
                        NavigationService.context)
                    .baseUrl;

                return CustomListTile(
                  title: widget.allCoops[index].bank,
                  description: "",
                  trailing: Container(),
                  imageUrl: _baseUrl + widget.allCoops[index].logo,
                  maxLines: 2,
                  onPressed: () {
                    widget.selectedCoop.value = widget.allCoops[index];
                    widget.onValueSelected(widget.allCoops[index]);
                    NavigationService.pop();
                  },
                  horizontalPadding: CustomTheme.symmetricHozPadding,
                );
              },
              childCount: widget.allCoops.length,
            ),
          ),
        ],
      ),
    );
  }
}
