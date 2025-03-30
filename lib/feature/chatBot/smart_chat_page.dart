import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/widget/page_wrapper.dart';
import 'package:ismart/feature/chatBot/SmartBot_topUp_service.dart';
import 'package:ismart/feature/chatBot/smart_chat_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';
import 'smart_chat_page_state.dart';

class SmartChatPage extends StatefulWidget {
  final String? receiverEmail;
  final int? id;
  const SmartChatPage({
    Key? key,
    this.receiverEmail = "iSmart",
    this.id,
  }) : super(key: key);

  @override
  State<SmartChatPage> createState() => _SmartChatPageState();
}

class _SmartChatPageState extends SmartChatPageState {
  late final CategoryService _categoryService;

  @override
  void initState() {
    super.initState();
    _categoryService = CategoryService();
    _initializeCategoryService();
  }

  Future<void> _initializeCategoryService() async {
    await _categoryService.initialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UtilityPaymentCubit(
            utilityPaymentRepository:
                RepositoryProvider.of<UtilityPaymentRepository>(context),
          ),
        ),
      ],
      child: BlocListener<CategoryCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonDataFetchSuccess<CategoryList>) {
            _categoryService.updateCategoryList(state.data);
          }
        },
        child: PageWrapper(
          showBackButton: true,
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(child: buildMessageList(_categoryService)),
                  buildUserInput(_categoryService),
                ],
              ),
              Positioned(
                bottom: 68,
                child: Container(
                  height: 80,
                  width: 80,
                  child: Image.asset("assets/smart_fuchee.png"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
