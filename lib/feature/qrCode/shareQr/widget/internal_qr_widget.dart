import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:share_plus/share_plus.dart';

class InternalQrWidget extends StatelessWidget {
  final String qrPath;
  InternalQrWidget({Key? key, required this.qrPath}) : super(key: key);
  final detail =
      RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
          .selectedAccount
          .value!;
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return ListView(
      children: [
        Image.network(
          RepositoryProvider.of<CoOperative>(context).baseUrl + qrPath,
          height: _height * 0.4,
        ),
        KeyValueTile(
          title: "Name",
          value: detail.accountHolderName,
        ),
        KeyValueTile(
          title: "Account Number",
          value: detail.mainCode,
        ),
        SizedBox(height: _height * 0.02),
        CustomRoundedButtom(
          title: "Share",
          onPressed: () async {
            await Share.share(
                RepositoryProvider.of<CoOperative>(context).baseUrl + qrPath);
          },
        )
      ],
    );
  }
}
// delete all items inside a folder form terminal