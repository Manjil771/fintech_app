import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/resoures/wallet_load_repository.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/ui/widgets/wallet_transfer_widget.dart';

class WalletTransferScreen extends StatelessWidget {
  const WalletTransferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => WalletListCubit(
        walletLoadRepository:
            RepositoryProvider.of<WalletLoadRepository>(context),
      )..fetchWalletList(),
      child: WalletTransferWidget(),
    );
  }
}
