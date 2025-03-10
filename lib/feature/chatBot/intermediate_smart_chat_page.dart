import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/chatBot/smart_chat_page.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';

class SmartIntermeditate extends StatelessWidget {
  const SmartIntermeditate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(
        servicesRepository: RepositoryProvider.of<CategoryRepository>(context),
      )..fetchCategory(),
      child: const SmartChatPage(),
    );
  }
}
