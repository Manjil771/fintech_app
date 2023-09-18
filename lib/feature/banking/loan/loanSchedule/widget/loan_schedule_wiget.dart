import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/secure_storage_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

class LoanScheduleWidget extends StatefulWidget {
  LoanScheduleWidget({Key? key}) : super(key: key);

  @override
  State<LoanScheduleWidget> createState() => _LoanScheduleWidgetState();
}

class _LoanScheduleWidgetState extends State<LoanScheduleWidget> {
  bool _isLoading = false;
  Future getMpin() async {
    String mPin = await SecureStorageService.appPassword;
    if (mPin.isNotEmpty) {
      context.read<UtilityPaymentCubit>().fetchDetails(
          serviceIdentifier: "",
          accountDetails: {
            "accountNumber":
                RepositoryProvider.of<CustomerDetailRepository>(context)
                    .selectedAccount
                    .value!
                    .accountNumber,
            "mPin": mPin
          },
          apiEndpoint: "/api/loan/schedule");
    }
    print("mmpin is $mPin");
  }

  @override
  void initState() {
    getMpin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
        body: CommonContainer(
            topbarName: "Loan Schedule",
            showRoundBotton: false,
            body: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _theme.primaryColor.withOpacity(0.2),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 20.wp,
                        child: Center(
                          child: Text(
                            "SN",
                            style: _textTheme.labelMedium,
                          ),
                        )),
                    Expanded(
                        child: Center(
                      child: Text(
                        "Date",
                        style: _textTheme.labelMedium,
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(
                        "Installement",
                        style: _textTheme.labelMedium,
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(
                        "Principal",
                        style: _textTheme.labelMedium,
                      ),
                    )),
                    Expanded(
                        child: Center(
                      child: Text(
                        "Interest",
                        style: _textTheme.labelMedium,
                      ),
                    )),
                  ],
                ),
              ),
              BlocBuilder<UtilityPaymentCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonStateSuccess<UtilityResponseData>) {
                    final _response = state.data.findValue(primaryKey: "data");
                    if (state.data.details.isNotEmpty) {
                      return Column(
                        children: [
                          ...List.generate(state.data.details.length, (index) {
                            return Container(
                              padding: EdgeInsets.symmetric(vertical: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CustomTheme.darkerBlack)),
                              child: Row(
                                children: [
                                  Container(
                                      width: 20.wp,
                                      child: Center(
                                        child: Text(
                                          (index + 1).toString(),
                                          style: _textTheme.labelMedium,
                                        ),
                                      )),
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      "${_response[index]["scheduleDateNepali"].toString()}",
                                      style: _textTheme.labelMedium,

                                      // \n${_response[index]["scheduleDateNepali"]
                                    ),
                                  )),
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      _response[index]["scheduleAmount"]
                                          .toString(),
                                      style: _textTheme.labelMedium,
                                    ),
                                  )),
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      _response[index]["principal"].toString(),
                                      style: _textTheme.labelMedium,
                                    ),
                                  )),
                                  Expanded(
                                      child: Center(
                                    child: Text(
                                      _response[index]["interest"].toString(),
                                      style: _textTheme.labelMedium,
                                    ),
                                  )),
                                ],
                              ),
                            );
                          })
                        ],
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              )
            ])));
  }
}
