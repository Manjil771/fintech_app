import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_text_field.dart';
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

  List<LoginCoOpValue> _allCoops = [];
  List<LoginCoOpValue> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _allCoops = widget.allCoops;
    _searchResults = _allCoops;
  }

  _searchValue(String? query) {
    if (query == null) {
      _searchResults = List.from(_allCoops);

      setState(() {});
    }

    _searchResults = List.from(_allCoops);

    _searchResults = _searchResults
        .where((element) =>
            element.bank.toLowerCase().contains(query!.toLowerCase()))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    return PageWrapper(
      padding: EdgeInsets.zero,
      showBackButton: true,
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
                  "Cooperative",
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
                  "Select Cooperative",
                  style: _textTheme.titleLarge,
                ),
              ),
            ),
          if (_showTitleAndDesc)
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomTextField(
                hintText: "Enter to search",
                onChanged: (query) {
                  _searchValue(query);
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final String _baseUrl = RepositoryProvider.of<CoOperative>(
                        NavigationService.context)
                    .baseUrl;

                return CustomListTile(
                  title: _searchResults[index].bank,
                  description: "",
                  trailing: Container(),
                  imageUrl: _baseUrl + _searchResults[index].logo,
                  maxLines: 2,
                  onPressed: () {
                    widget.selectedCoop.value = _searchResults[index];
                    widget.onValueSelected(_searchResults[index]);
                    NavigationService.pop();
                  },
                  horizontalPadding: CustomTheme.symmetricHozPadding,
                );
              },
              childCount: _searchResults.length,
            ),
          ),
        ],
      ),
    );
  }
}
