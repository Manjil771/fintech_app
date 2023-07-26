import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/cubit/cerdit_card_cubit.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_bank_model.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/resource/credit_card_repository.dart';
import 'package:ismart/feature/categoryWiseService/creditCard/widget/credit_card_bank_list_widget.dart';
import 'package:ismart/feature/sendMoney/anyBank/widgets/bank_list_widget.dart';
import 'package:ismart/feature/sendMoney/cubits/send_to_bank_cubit.dart';
import 'package:ismart/feature/sendMoney/models/bank.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

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
