import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/cubit/datapack_cubit.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/resources/datapack_repository.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/widget/select_datapack_widget.dart';
import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';

class SelectDatapackScreen extends StatelessWidget {
  final ServiceList service;
  const SelectDatapackScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatapackCubit(
          datapackRepository:
              RepositoryProvider.of<DatapackRepository>(context)),
      child: SelectDatapackWidget(
        service: service,
      ),
    );
  }
}
