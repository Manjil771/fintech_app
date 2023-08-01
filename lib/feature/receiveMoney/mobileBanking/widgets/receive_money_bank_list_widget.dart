import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/custom_list_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/receiveMoney/cubit/receive_money_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';

class ReceiveMoneyBanksListWidget extends StatefulWidget {
  const ReceiveMoneyBanksListWidget(
      {Key? key, required this.onBankSelected, required this.type})
      : super(key: key);
  final Function(Bank) onBankSelected;
  final String type;
  @override
  State<ReceiveMoneyBanksListWidget> createState() =>
      _ReceiveMoneyBanksListWidgetState();
}

class _ReceiveMoneyBanksListWidgetState
    extends State<ReceiveMoneyBanksListWidget> {
  bool _showTitleAndDesc = true;

  @override
  void initState() {
    super.initState();
    context.read<ReceiveMoneyCubit>().fetchBanksList(type: widget.type);
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
                  "Banks",
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
                  "Select bank",
                  style: _textTheme.titleLarge,
                ),
              ),
            ),
          if (_showTitleAndDesc)
            const SliverToBoxAdapter(child: SizedBox(height: 25)),
          BlocConsumer<ReceiveMoneyCubit, CommonState>(
              listener: (context, state) {
            if (state is CommonError) {
              if ((state.statusCode ?? 400) >= 400 &&
                  (state.statusCode ?? 400) <= 600 &&
                  state.statusCode != 404) {
                setState(() {
                  _showTitleAndDesc = false;
                });
              }
            }
          }, builder: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: CommonLoadingWidget(),
              );
            }
            if (state is CommonDataFetchSuccess<Bank>) {
              List<Bank> _list = state.data;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return CustomListTile(
                      title: _list[index].bankName,
                      description: "",
                      trailing: Container(),
                      imageUrl: _list[index].iconUrl,
                      onPressed: () {
                        widget.onBankSelected(_list[index]);
                      },
                      horizontalPadding: CustomTheme.symmetricHozPadding,
                    );
                  },
                  childCount: _list.length,
                ),
              );
            } else if (state is CommonLoadingWidget) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: CommonLoadingWidget(),
              );
            } else if (state is CommonError) {
              if ((state.statusCode ?? 400) >= 400 &&
                  (state.statusCode ?? 400) <= 600 &&
                  state.statusCode != 404) {
                return const SliverFillRemaining(
                  hasScrollBody: false,
                  child: CommonLoadingWidget(), 
                );
              }
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                  child: Center(child: Text(state.message)),
                ),
              );
            } else {
              return SliverToBoxAdapter(child: Container());
            }
          }),
        ],
      ),
    );
  }
}
