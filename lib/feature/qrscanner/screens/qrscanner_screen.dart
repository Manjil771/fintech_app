import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/qrCode/shareQr/resources/qr_repository.dart';
import 'package:ismart/feature/qrscanner/widgets/qrscanner_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class QRScannerScreens extends StatelessWidget {
  // final ValueChanged<MpqrcDetail> onScanned;
  // final QRType type;
  const QRScannerScreens({
    Key? key,
    // required this.onScanned,
    // required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppServiceCubit(
              appServiceRepository:
                  RepositoryProvider.of<AppServiceRepository>(context))
            ..fetchAppService(),
        ),
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
              utilityPaymentRepository:
                  RepositoryProvider.of<UtilityPaymentRepository>(context)),
        ),
      ],
      child: const QRScannerWidgets(
          // onScanned: onScanned,
          // type: type,
          ),
    );
  }
}
