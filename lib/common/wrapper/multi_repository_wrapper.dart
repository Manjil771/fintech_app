import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/http/api_provider.dart';
import 'package:ismart/feature/authentication/resource/user_repository.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/service_repository.dart';
import 'package:ismart/feature/history/resources/recent_transaction_repository.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_from_bank_repository.dart';
import 'package:ismart/feature/receiveMoney/resources/receive_money_repository.dart';
import 'package:ismart/feature/sendMoney/internalCooperative/resources/internal_transfer_repository.dart';
import 'package:ismart/feature/sendMoney/resources/send_to_bank_repository.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/resoures/wallet_load_repository.dart';
import 'package:ismart/feature/splash/resource/startup_repository.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_repository.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class MultiRepositoryWrapper extends StatelessWidget {
  final Widget child;
  final CoOperative env;
  const MultiRepositoryWrapper({required this.child, required this.env});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CoOperative>(
          create: (context) => env,
          lazy: true,
        ),
        // RepositoryProvider<InternetCheck>(
        //   create: (context) => InternetCheck(),
        //   lazy: true,
        // ),
        RepositoryProvider<ApiProvider>(
          create: (context) => ApiProvider(
            baseUrl: env.baseUrl,
          ),
          lazy: true,
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(
            env: RepositoryProvider.of<CoOperative>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          )..initialState(),
          lazy: true,
        ),
        RepositoryProvider<StartUpRepository>(
          create: (context) => StartUpRepository(
            env: RepositoryProvider.of<CoOperative>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
          lazy: true,
        ),

        RepositoryProvider<UtilityPaymentRepository>(
          create: (context) => UtilityPaymentRepository(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            env: RepositoryProvider.of<CoOperative>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider<SendToBankRepository>(
          create: (context) => SendToBankRepository(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            env: RepositoryProvider.of<CoOperative>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => CustomerDetailRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => MiniStatementRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => FullStatementRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider<ReceiveFromBankRepository>(
          create: (context) => ReceiveFromBankRepository(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            env: RepositoryProvider.of<CoOperative>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider<RecentTransactionRepository>(
          create: (context) => RecentTransactionRepository(
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => WalletLoadRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(
          create: (context) => ReceiveMoneyRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),
          ),
          lazy: true,
        ),
        RepositoryProvider(

          create: (context) => ServicesRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            coOperative: RepositoryProvider.of<CoOperative>(context),

          create: (context) => InternalTransferRepository(
            apiProvider: RepositoryProvider.of<ApiProvider>(context),
            userRepository: RepositoryProvider.of<UserRepository>(context),
            env: RepositoryProvider.of<CoOperative>(context),

          ),
          lazy: true,
        )
      ],
      child: child,
    );
  }
}
