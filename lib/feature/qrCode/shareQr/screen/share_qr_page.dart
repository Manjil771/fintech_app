import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/qrCode/shareQr/widget/share_qr_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class ShareQrPage extends StatelessWidget {
  ShareQrPage({Key? key}) : super(key: key);
  final detail =
      RepositoryProvider.of<CustomerDetailRepository>(NavigationService.context)
          .accountsList
          .value
          .firstWhere((element) => element.primary.toString() == "true");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context))
        ..fetchDetails(
          serviceIdentifier: "",
          accountDetails: {
            "customerName": detail.accountHolderName,
            "customerBankAccountId": detail.id,
          },
          apiEndpoint: "api/generateAndQRCodeNew",
        ),
      child: const ShareQrWidget(),
    );
  }
}
