import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/locale_keys.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class ForexWidget extends StatefulWidget {
  const ForexWidget({super.key});

  @override
  State<ForexWidget> createState() => _ForexWidgetState();
}

class _ForexWidgetState extends State<ForexWidget> {
  @override
  Widget build(BuildContext context) {
    bool _isLoading = false;
    return PageWrapper(
        padding: const EdgeInsets.all(0),
        showBackButton: true,
        showChatBot: false,
        body: BlocConsumer<UtilityPaymentCubit, CommonState>(
          listener: (context, state) {
            if (state is CommonLoading && _isLoading == false) {
              _isLoading = true;
              showLoadingDialogBox(context);
            } else if (state is! CommonLoading && _isLoading) {
              _isLoading = false;
              NavigationService.pop();
            }
            if (state is CommonError) {
              showPopUpDialog(
                context: context,
                message: state.message,
                title: "Error",
                showCancelButton: false,
                buttonCallback: () {
                  NavigationService.pop();
                },
              );
            }
          },
          builder: (context, state) {
            if (state is CommonStateSuccess<UtilityResponseData>) {
              final List response = state.data.findValue(primaryKey: "data");
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            dataTableTheme: DataTableThemeData(
                              headingRowColor: WidgetStateProperty.all(
                                  CustomTheme.primaryColor),
                              headingTextStyle: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          child: DataTable(
                            columns: [
                              DataColumn(
                                  label: Text(
                                LocaleKeys.currency.tr(),
                              )),
                              DataColumn(
                                  label: Text(
                                LocaleKeys.unit.tr(),
                              )),
                              DataColumn(
                                  label: Text(
                                LocaleKeys.buyingRs.tr(),
                              )),
                              DataColumn(
                                  label: Text(
                                LocaleKeys.sellingRs.tr(),
                              )),
                            ],
                            rows: List.generate(
                              response.length,
                              (index) {
                                final row = response[index];
                                return DataRow(
                                  cells: [
                                    DataCell(Text(row['BaseCurrency'] ?? '')),
                                    DataCell(Text(row['BaseValue'] ?? '')),
                                    DataCell(Text(row['TargetBuy'] ?? '')),
                                    DataCell(Text(row['TargetSell'] ?? '')),
                                  ],
                                );
                              },
                            ),
                          ),
                        )),
                  );
                },
              );
            } else if (state is CommonError) {
              return NoDataScreen(title: "Error", details: state.message);
            } else if (state is CommonLoading) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [CommonLoadingWidget()],
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
