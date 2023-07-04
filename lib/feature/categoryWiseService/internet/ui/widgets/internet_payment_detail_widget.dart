import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/form_validator.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_text_field.dart';
import 'package:ismart/common/widget/custom_checkbox.dart';
import 'package:ismart/common/widget/key_value_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/scaffold_topbar.dart';
import 'package:ismart/common/widget/transactipon_pin_screen.dart';
import 'package:ismart/feature/categoryWiseService/internet/worldlink/widgets/worldlink_search_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

import '../../../../../common/util/size_utils.dart';

class InternetPaymentDeatilWidget extends StatefulWidget {
  final UtilityResponseData detailFetchData;

  const InternetPaymentDeatilWidget({super.key, required this.detailFetchData});
  @override
  State<InternetPaymentDeatilWidget> createState() =>
      _InternetPaymentDeatilWidgetState();
}

class _InternetPaymentDeatilWidgetState
    extends State<InternetPaymentDeatilWidget> {
  final TextEditingController _packageController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _changePackage = false;
  final bool _isLoading = false;
  String _selectedPackageId = "";

  double _dueAmount = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _dueAmount = double.tryParse(widget.detailFetchData
                .findValue(primaryKey: "due_amount_till_now")
                ?.toString() ??
            "0") ??
        0;
    _amountController.text = ((double.tryParse(widget.detailFetchData
                    .findValueString("amount", emptyString: "")) ??
                0) +
            _dueAmount)
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    final bool _renewOption = widget.detailFetchData
            .findValue<List>(primaryKey: "packages")
            ?.isNotEmpty ??
        false;
    final _packageOptions = List.from((_renewOption
            ? widget.detailFetchData.findValue(primaryKey: "packages")
            : widget.detailFetchData
                .findValue(primaryKey: "package_options")) ??
        []);

    final bool _isPackageAvailable = _packageOptions.isNotEmpty;
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        topbarName: 'Payment',
        title: 'Internet Payment',
        buttonName: 'Proceed',
        detail: 'Pay your internet bill of you ISP from here',
        showAccountSelection: true,
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Details",
                  style: _textTheme.titleMedium,
                ),
                SizedBox(height: _height * 0.01),
                KeyValueTile(
                  title: "Customer Name",
                  value: widget.detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "customerName",
                      )
                      .toString(),
                ),
                SizedBox(height: _height * 0.008),
                KeyValueTile(
                  title: "Customer ID",
                  value: widget.detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "wlinkUserName",
                      )
                      .toString(),
                ),
                SizedBox(height: _height * 0.008),
                KeyValueTile(
                  title: "Subscribed Package",
                  value: widget.detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "subscribedPackageName",
                      )
                      .toString(),
                ),
                SizedBox(height: _height * 0.008),
                KeyValueTile(
                  title: "Subscription Type",
                  value: widget.detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "subscribedPackageType",
                      )
                      .toString(),
                ),
                SizedBox(height: _height * 0.008),
                KeyValueTile(
                  title: "Days Remaining",
                  value: widget.detailFetchData
                      .findValue(
                        primaryKey: "hashResponse",
                        secondaryKey: "paymentMessage",
                      )
                      .toString(),
                ),
                if (_isPackageAvailable)
                  CustomCheckbox(
                    leftMargin: CustomTheme.symmetricHozPadding,
                    selected: _changePackage,
                    onChanged: (val) {
                      setState(() {
                        _changePackage = val;
                      });
                    },
                    title: "Change Package",
                  ),
                SizedBox(height: _height * 0.02),
                if (_isPackageAvailable)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    transitionBuilder: (child, animation) {
                      return SizeTransition(
                        sizeFactor: animation,
                        axis: Axis.vertical,
                        child: child,
                      );
                    },
                    child: OpenContainer(
                      closedColor: Colors.transparent,
                      closedElevation: 0.0,
                      openElevation: 0,
                      transitionType: ContainerTransitionType.fade,
                      closedBuilder: (context, open) {
                        return CustomTextField(
                          margin: const EdgeInsets.only(
                            left: CustomTheme.symmetricHozPadding,
                            right: CustomTheme.symmetricHozPadding,
                          ),
                          controller: _packageController,
                          title: "",
                          hintText: "Renew Options",
                          showSearchIcon: true,
                          readOnly: true,
                          required: true,
                          suffixIcon: Icons.keyboard_arrow_down_rounded,
                          onTap: open,
                          validator: (val) {
                            return FormValidator.validateFieldNotEmpty(
                              val,
                              "Renew Options",
                            );
                          },
                        );
                      },
                      openBuilder: (context, close) {
                        return WorldlinkSearchWidgets(
                          useServiceResponse: widget.detailFetchData,
                          renewOptions: _renewOption,
                          onChanged: (val) {
                            _packageController.text = val["text"] ?? "";
                            _selectedPackageId = val["id"]?.toString() ?? "";
                            _amountController.text = ((double.tryParse(
                                            val["amount"]?.toString() ?? "0") ??
                                        0) +
                                    _dueAmount)
                                .toString();
                          },
                        );
                      },
                    ),
                  ),
                if (_changePackage || (_isPackageAvailable == false))
                  SizedBox(height: 20.hp),

                // CustomTextField(title: "Amount", hintText: "Enter the amount"),
                SizedBox(height: _height * 0.01),
                // Container(
                //   padding: const EdgeInsets.only(top: 7),
                //   height: _height * 0.12,
                //   width: double.infinity,
                //   child: GridView.builder(
                //     itemCount: 6,
                //     gridDelegate:
                //         const SliverGridDelegateWithFixedCrossAxisCount(
                //             crossAxisCount: 3, childAspectRatio: 1.4 / 0.6),
                //     itemBuilder: (context, index) => amountBox(context, index),
                //   ),
                // ),
              ],
            ),
          ],
        ),
        onButtonPressed: () {
          NavigationService.push(
            target: TransactionPinScreen(
              onValueCallback: (mpin) {
                NavigationService.pop();
                context.read<UtilityPaymentCubit>().makePayment(
                      body: widget.detailFetchData
                          .findValue(primaryKey: "hashResponse"),
                      serviceIdentifier: "worldlink_online_topup",
                      accountDetails: {
                        "wlink_username": widget.detailFetchData.findValue(
                          primaryKey: "hashResponse",
                          secondaryKey: "wlinkUserName",
                        ),
                        "amount": "",
                        "account_number":
                            RepositoryProvider.of<CustomerDetailRepository>(
                                    context)
                                .selectedAccount
                                .value
                                ?.accountNumber,
                        "mPin": mpin,
                      },
                      apiEndpoint: "api/wlinkpay",
                    );
              },
            ),
          );
        },
      ),
    );
  }

  // amountBox(context, index) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 7),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(color: Colors.black),
  //     ),
  //     child: Center(child: Text(amount[index].toString())),
  //   );
  // }

  // final List amount = [100, 200, 500, 1000, 2000, 5000];
}
