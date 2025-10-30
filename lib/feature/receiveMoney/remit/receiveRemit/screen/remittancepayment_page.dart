import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class RemittancepaymentPage extends StatelessWidget {
  final ServiceList service;
  final String senderName;
  final String senderCountry;
  final String amount;
  final String paymentType;
  final String date;
  final String status;
  final String id;
  const RemittancepaymentPage({
    super.key,
    required this.service,
    required this.senderName,
    required this.senderCountry,
    required this.amount,
    required this.paymentType,
    required this.date,
    required this.status,
    required this.id,
  });

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
        service: ServiceList(
            url: Url.URL,
            id: 0,
            uniqueIdentifier: "remittance",
            service: "Remittance Payment",
            status: Status.ACTIVE,
            labelName: "",
            labelMaxLength: "10",
            labelMinLength: "",
            labelSample: "",
            labelPrefix: "",
            instructions: "",
            fixedlabelSize: true,
            priceInput: true,
            notificationUrl: "remittance",
            minValue: 0.0,
            maxValue: 5000.0,
            icon: '',
            categoryId: 21,
            serviceCategoryName: "",
            webView: true,
            isNew: true,
            appOrder: 0,
            isSmsMode: true),
        serviceIdentifier: '',
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KeyValueTile(
              title: "Sender Name",
              value: senderName,
            ),
            KeyValueTile(
              title: "Sender Country",
              value: senderCountry,
            ),
            KeyValueTile(
              title: "Amount",
              value: amount,
            ),
            KeyValueTile(
              title: "Payment type",
              value: paymentType,
            ),
            KeyValueTile(
              title: "Date",
              value: date,
            ),
            KeyValueTile(
              title: "Status",
              value: status,
            ),
          ],
        ),
      ),
    );
  }
}
