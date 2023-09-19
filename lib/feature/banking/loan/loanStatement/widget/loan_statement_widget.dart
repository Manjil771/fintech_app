import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/constant/env.dart';
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

class LoanStatementWidget extends StatefulWidget {
  final UtilityResponseData response;

  LoanStatementWidget({Key? key, required this.response}) : super(key: key);

  @override
  State<LoanStatementWidget> createState() => _LoanStatementWidgetState();
}

class _LoanStatementWidgetState extends State<LoanStatementWidget> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    final _response = widget.response.findValue(primaryKey: "data");
    return PageWrapper(
        body: CommonContainer(
            verticalPadding: 0,
            horizontalPadding: 0,
            topbarName: "Loan Statement",
            showRoundBotton: false,
            showDetail: false,
            showTitleText: false,
            body: widget.response.details.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        height: 60.hp,
                        color: _theme.primaryColor.withOpacity(0.05),
                        child: Row(children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              child: Center(
                                  child: Text(
                                "SN",
                                style: _textTheme.headlineSmall!
                                    .copyWith(fontSize: 12),
                              )),
                            ),
                          ),
                          Flexible(
                            flex: 10,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Date",
                                      style: _textTheme.headlineSmall!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Center(
                                      child: Text("Issued Amount",
                                          textAlign: TextAlign.center,
                                          style: _textTheme.headlineSmall!
                                              .copyWith(fontSize: 12)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Principal",
                                      style: _textTheme.headlineSmall!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Balance",
                                      style: _textTheme.headlineSmall!
                                          .copyWith(fontSize: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _response.length,
                          itemBuilder: (context, index) {
                            return Container(
                              color: index.isOdd
                                  ? CustomTheme.white
                                  : _theme.primaryColor.withOpacity(0.03),
                              padding: EdgeInsets.symmetric(vertical: 10.hp),
                              child: Row(children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    child: Center(child: Text("${index + 1}")),
                                  ),
                                ),
                                Flexible(
                                  flex: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: Center(
                                              child: Text(_response[index]
                                                      ["tranDate"]
                                                  .toString()),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  _response[index]
                                                          ["issuedAmount"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: CustomTheme
                                                          .googleColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Center(
                                              child: Text(_response[index]
                                                      ["principal"]
                                                  .toString()),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Center(
                                              child: Text(_response[index]
                                                      ["balance"]
                                                  .toString()),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2.hp),
                                      Text(_response[index]
                                          ["statementReference"])
                                    ],
                                  ),
                                )
                              ]),
                            );
                          })
                    ],
                  )
                : Container()

            // ),

            ));
  }
}
