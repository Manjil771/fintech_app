import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/constant/assets.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_bill_details_screen.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../dashboard/screen/dashboard_page.dart';

class InsuranceBillDetailWidget extends StatelessWidget {
  final UtilityResponseData detailFetchData;
  final Service service;
  final String dateofBirth;

  const InsuranceBillDetailWidget({
    Key? key,
    required this.detailFetchData,
    required this.service,
    required this.dateofBirth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      showAppBar: false,
      body: Column(
        children: [
          CommonBillDetailPage(
            image:
                "${RepositoryProvider.of<CoOperative>(context).baseUrl}/ismart/serviceIcon/${service.icon}",
            serviceType: service.service,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                KeyValueTile(
                  title: "Policy Number",
                  value: detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "policyNo",
                      )
                      .toString(),
                ),
                KeyValueTile(
                  title: "Username",
                  value: detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "policyName",
                      )
                      .toString(),
                ),
                KeyValueTile(
                  title: "Amount",
                  value: detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "amount",
                      )
                      .toString(),
                ),
                KeyValueTile(
                  title: "Premium",
                  value: detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "premium",
                      )
                      .toString(),
                ),
                KeyValueTile(
                  title: "Due Date",
                  value: detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "dueDate",
                      )
                      .toString(),
                ),
                KeyValueTile(
                  title: "Penalty",
                  value: detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "interestOccured",
                      )
                      .toString(),
                ),
              ],
            ),
            onButtonPress: () {
              NavigationService.push(
                target: TransactionPinScreen(
                  onValueCallback: (mpin) {
                    NavigationService.pop();
                    context.read<UtilityPaymentCubit>().payInsurance(
                          dob: dateofBirth,
                          serviceIdentifier: service.uniqueIdentifier,
                          amount: detailFetchData
                              .findValue(
                                primaryKey: "hashResponse",
                                secondaryKey: "premium",
                              )
                              .toString(),
                          mpin: mpin,
                        );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
