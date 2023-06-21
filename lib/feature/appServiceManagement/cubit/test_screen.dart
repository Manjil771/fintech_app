import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/app/theme.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/common_container.dart';
import 'package:ismart/common/widget/common_loading_widget.dart';
import 'package:ismart/common/widget/custom_list_tile.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/common/widget/show_loading_dialog.dart';
import 'package:ismart/common/widget/show_pop_up_dialog.dart';
import 'package:ismart/common/widget/transaction_detail_box.dart';
import 'package:ismart/feature/appServiceManagement/cubit/app_service_cubit.dart';
import 'package:ismart/feature/appServiceManagement/model/app_service_management_model.dart';
import 'package:flutter/material.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/appServiceManagement/resource/app_service_repository.dart';

class TestScreenPage extends StatelessWidget {
  const TestScreenPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
        create: (context) => AppServiceCubit(
              appServiceRepository:
                  RepositoryProvider.of<AppServiceRepository>(context),
            ),
        child: TestScreenBAnking());
  }
}

class TestScreenBAnking extends StatefulWidget {
  const TestScreenBAnking({Key? key}) : super(key: key);

  @override
  State<TestScreenBAnking> createState() => _TestScreenBAnkingState();
}

class _TestScreenBAnkingState extends State<TestScreenBAnking> {
  @override
  void initState() {
    super.initState();
    context.read<AppServiceCubit>().fetchrecentTransaction();
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _height = SizeUtils.height;
    return PageWrapper(
      showAppBar: false,
      body: BlocConsumer<AppServiceCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonLoading && !_isLoading) {
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
          if (state is CommonDataFetchSuccess<AppServiceManagementModel>) {
            return CommonContainer(
                showDetail: false,
                showBackBotton: false,
                showRoundBotton: false,
                body: Container(
                  height: _height * 0.65,
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      final _detail = state.data;
                      return TransactionDetailBox(
                        title: _detail[index].status.toString(),
                        leadingImage: Container(),
                        balance: _detail[index].name,
                        status: _detail[index].status.toString(),
                        amount: _detail[index].status.toString(),
                        dateTime: _detail[index].status.toString(),
                        desc: _detail[index].status.toString(),
                      );
                    },
                  ),
                ),
                showTitleText: false,
                topbarName: "Recent Transaction");
          } else {
            return Container(
              child: Text("my state " + state.toString()),
            );
          }
        },
      ),
    );
  }
}
