import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';

import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_button.dart';
import 'package:ismart/common/widget/common_container.dart';

import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/screen/buy_datapack_screen.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:shimmer/shimmer.dart';

class SelectDatapackWidget extends StatefulWidget {
  SelectDatapackWidget({Key? key, required this.service}) : super(key: key);
  final Service service;

  @override
  State<SelectDatapackWidget> createState() => _SelectDatapackWidgetState();
}

class _SelectDatapackWidgetState extends State<SelectDatapackWidget> {
  int? selectedIdex;
  bool viewMore = false;
  @override
  void initState() {
    super.initState();
    context.read<UtilityPaymentCubit>().fetchDetails(
        accountDetails: {},
        apiEndpoint: '/api/data_pack/packages',
        serviceIdentifier: widget.service.uniqueIdentifier);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        showDetail: true,
        showRoundBotton: false,
        topbarName: 'Payment',
        title: 'Buy Data Packs',
        detail: 'Buy your data packs from here',
        showTitleText: true,
        body: Container(
            height: _height * 0.7,
            child: BlocBuilder<UtilityPaymentCubit, CommonState>(
              builder: (context, state) {
                if (state is CommonStateSuccess<UtilityResponseData>) {
                  final List _list =
                      state.data.findValue(primaryKey: 'packages');

                  final lent = _list.length;

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _list.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                            color: CustomTheme.backgroundColor,
                            borderRadius: BorderRadius.circular(18)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                          _list[index]['imagePath'])),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Text(
                                    _list[index]['name'],
                                    style: _textTheme.displaySmall!
                                        .copyWith(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'NPR',
                                      style: _textTheme.headlineSmall,
                                    ),
                                    Text(
                                      '${_list[index]['amount'].toString()}',
                                      style: _textTheme.displaySmall!
                                          .copyWith(fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        maxLines:
                                            selectedIdex == index ? 10 : 1,
                                        _list[index]['description'].toString(),
                                        style: _textTheme.titleSmall!.copyWith(
                                          color: CustomTheme.darkGray,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        width: double.maxFinite,
                                        child: CustomRoundedButtom(
                                            verticalPadding: 5,
                                            color: Colors.transparent,
                                            textColor: CustomTheme.primaryColor,
                                            borderColor: Colors.transparent,
                                            fontSize: 12,
                                            title: selectedIdex == index
                                                ? 'View Less'
                                                : 'View More',
                                            onPressed: () {
                                              if (viewMore == false) {
                                                setState(() {
                                                  selectedIdex = index;
                                                  viewMore = !viewMore;
                                                });
                                              } else {
                                                setState(() {
                                                  selectedIdex = null;
                                                  viewMore = !viewMore;
                                                });
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomRoundedButtom(
                                  verticalPadding: 10,
                                  fontSize: 10,
                                  title: 'Buy Now',
                                  onPressed: () {
                                    NavigationService.push(
                                        target: BuyDatapackScreen(
                                      service: widget.service,
                                      package: _list[index],
                                    ));
                                  },
                                  color: CustomTheme.backgroundColor,
                                  textColor: CustomTheme.primaryColor,
                                  borderColor: CustomTheme.primaryColor,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is CommonError) {
                  return Text(state.message.toString());
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: CustomTheme.lightGray,
                        highlightColor: CustomTheme.backgroundColor,
                        child: Container(
                          height: 150,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: CustomTheme.backgroundColor,
                              borderRadius: BorderRadius.circular(18)),
                        ),
                      );
                    },
                  );
                }
              },
            )),
      ),
    );
  }
}
