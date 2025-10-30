import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/cubit/datapack_cubit.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/model/datapack_model.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/widget/data_pack_list_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:shimmer/shimmer.dart';

class SelectDatapackWidget extends StatefulWidget {
  const SelectDatapackWidget({Key? key, required this.service})
      : super(key: key);
  final ServiceList service;

  @override
  State<SelectDatapackWidget> createState() => _SelectDatapackWidgetState();
}

class _SelectDatapackWidgetState extends State<SelectDatapackWidget> {
  @override
  void initState() {
    super.initState();
    context
        .read<DatapackCubit>()
        .fetchDatapack(widget.service.uniqueIdentifier);
  }

  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
      body: CommonContainer(
        verticalPadding: 0,
        showRoundBotton: false,
        topbarName: 'Data Pack'.tr(),

        // title: 'Buy Data Packs',
        // detail: 'Buy your data packs from here',
        showTitleText: false,
        body: Container(
            height: _height * 0.7,
            child: BlocBuilder<DatapackCubit, CommonState>(
              builder: (context, state) {
                //ROAMING,VOICE,DATA,COMBO
                if (state is CommonDataFetchSuccess<DataPackPackage>) {
                  final List<DataPackPackage> voiceList = state.data
                      .where(
                        (element) => element.category.toLowerCase() == "voice",
                      )
                      .toList();
                  final List<DataPackPackage> roamingList = state.data
                      .where(
                        (element) =>
                            element.category.toLowerCase() == "roaming",
                      )
                      .toList();
                  final List<DataPackPackage> dataPackList = state.data
                      .where(
                        (element) => element.category.toLowerCase() == "data",
                      )
                      .toList();
                  final List<DataPackPackage> comboList = state.data
                      .where(
                        (element) => element.category.toLowerCase() == "combo",
                      )
                      .toList();
                  return DefaultTabController(
                    length: 5,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: true,
                          labelColor: Colors.black,
                          unselectedLabelColor: Color(0xFF989898),
                          labelStyle: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                          indicatorColor: Colors.transparent,
                          automaticIndicatorColorAdjustment: true,
                          tabs: [
                            Tab(text: "All".tr()),
                            Tab(text: "Data".tr()),
                            Tab(text: "Voice".tr()),
                            Tab(text: "Combo".tr()),
                            Tab(
                              text: "Roaming".tr(),
                            )
                          ],
                        ),
                        Expanded(
                          child: TabBarView(children: [
                            DataPackList(
                                dataList: state.data, service: widget.service),
                            DataPackList(
                                dataList: dataPackList,
                                service: widget.service),
                            DataPackList(
                                dataList: voiceList, service: widget.service),
                            DataPackList(
                                dataList: comboList, service: widget.service),
                            DataPackList(
                                dataList: roamingList, service: widget.service),
                          ]),
                        )
                      ],
                    ),
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
