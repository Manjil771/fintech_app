import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RemittancepaymentPage extends StatelessWidget {
  final ServiceList service;
  final String id;
  const RemittancepaymentPage(
      {super.key, required this.id, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: CommonBillDetailPage(
        serviceName: '',
        accountDetails: {
          "id": id,
          "relationship": 'Self',
          "relationshipType": 'Self',
          "remittancePurpose": 'Business',
        },
        apiEndpoint: "remittance/payTransactionConfirm",
        apiBody: const {},
        service: service,
        serviceIdentifier: '',
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KeyValueTile(
              title: "Customer Code",
              value: '',
            ),
          ],
        ),
      ),
    );
  }
}
