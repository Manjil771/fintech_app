import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/category_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/category_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/widget/category_widget.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';

class CategoryPage extends StatefulWidget {
  final bool showAllServices;

  const CategoryPage({super.key, required this.showAllServices});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit(
        servicesRepository: RepositoryProvider.of<CategoryRepository>(context),
      ),
      child: CategoryWidget(showAllService: widget.showAllServices),
    );
  }
}
