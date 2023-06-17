import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/cubit/service_cubit.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/resources/service_repository.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/widget/service_widget.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';

class ServicesPage extends StatefulWidget {
  final bool showAllServices;

  const ServicesPage({super.key, required this.showAllServices});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServicesCubit(
        servicesRepository: RepositoryProvider.of<ServicesRepository>(context),
      ),
      child: const ServicesWidget(),
    );
  }
}
