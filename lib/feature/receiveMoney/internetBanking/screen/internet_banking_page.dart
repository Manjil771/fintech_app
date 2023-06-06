import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/receiveMoney/cubit/receive_money_cubit.dart';
import 'package:ismart/feature/receiveMoney/internetBanking/widget/internet_banking_widget.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';

class InternetBankingPage extends StatelessWidget {
  const InternetBankingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => ReceiveMoneyCubit(
        receiveMoneyRepository:
            RepositoryProvider.of<ReceiveMoneyRepository>(context),
      ),
      child: const InternetBankingWidget(),
    );
  }
}
