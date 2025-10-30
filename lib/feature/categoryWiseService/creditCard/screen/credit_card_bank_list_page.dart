import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/cubit/cerdit_card_cubit.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_bank_model.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_repository.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/widget/credit_card_bank_list_widget.dart';

class CreditCardBankListPage extends StatelessWidget {
  const CreditCardBankListPage({Key? key, required this.onBankSelected})
      : super(key: key);
  final Function(CreditCardBankList) onBankSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditCardCubit(
        creditCardRepository:
            RepositoryProvider.of<CreditCardRepository>(context),
      ),
      child: CreditCardBankListWidget(
        onBankSelected: onBankSelected,
      ),
    );
  }
}
