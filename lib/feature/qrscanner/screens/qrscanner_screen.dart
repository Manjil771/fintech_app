import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';
import 'package:ismart/feature/qrscanner/widgets/qrscanner_widget.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/cubit/wallet_list_cubit.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/model/wallet_model.dart';
import 'package:ismart/feature/sendMoney/wallet_transfer/resoures/wallet_load_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class QRScannerScreens extends StatelessWidget {
  final String? remarks;
  final bool? isDigitalDakxhina;
  // final ValueChanged<MpqrcDetail> onScanned;
  // final QRType type;
  const QRScannerScreens({
    Key? key,
    this.remarks,
    this.isDigitalDakxhina,
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
          BlocProvider(
            create: (context) => WalletListCubit(
                walletLoadRepository:
                    RepositoryProvider.of<WalletLoadRepository>(context))
              ..fetchWalletList(),
          ),
        ],
        child: BlocBuilder<WalletListCubit, CommonState>(
          builder: (context, state) {
            if (state is CommonDataFetchSuccess<WalletModel>) {
              final List<WalletModel> _walletList = state.data;

              final qrScannerWidgets = QRScannerWidgets(
                walletLists: _walletList,
                remarks: remarks,
                isDigitalDakxhina: isDigitalDakxhina,
              );
              return qrScannerWidgets;
            }
            if (state is CommonLoading) {
              return const CommonLoadingWidget();
            } else if (state is CommonError) {
              return const PageWrapper(
                  showAppBar: true,
                  showBackButton: true,
                  body: NoDataScreen(
                      title: "No Wallet List Found",
                      details: "Please contact your Co-operative"));
            }
            return Container();
          },
        ));
  }
}
