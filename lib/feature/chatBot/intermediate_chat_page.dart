import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/chatBot/smart_chat_page.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class IntermediateChatPage extends StatelessWidget {
  final int id;
  const IntermediateChatPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
        utilityPaymentRepository:
            RepositoryProvider.of<UtilityPaymentRepository>(context),
      ),
      child: SmartChatPage(
        id: id,
      ),
    );
  }
}
