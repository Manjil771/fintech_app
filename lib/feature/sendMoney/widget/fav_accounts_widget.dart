import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/favorite/listFavAccount/screen/list_fav_account_page.dart';

class FavAccountsWidget extends StatefulWidget {
  const FavAccountsWidget({super.key});

  @override
  State<FavAccountsWidget> createState() => _FavAccountsWidgetState();
}

class _FavAccountsWidgetState extends State<FavAccountsWidget> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
        title: '',
        body: CommonContainer(
            verticalPadding: 0,
            topbarName: LocaleKeys.favorite.tr(),
            showRoundBotton: false,
            body: ListFavAccountPage()));
  }
}
