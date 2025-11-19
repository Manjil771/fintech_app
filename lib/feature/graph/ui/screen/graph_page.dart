import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/graph/ui/widget/graph_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
            serviceIdentifier: "",
            accountDetails: {
              "accountNumber":
                  RepositoryProvider.of<CustomerDetailRepository>(context)
                      .selectedAccount
                      .value!
                      .accountNumber,
            },
            apiEndpoint: "api/graph/balance"),
      child: const GraphWidget(),
    );
  }
}
