import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/cubit/datapack_cubit.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/resources/datapack_repository.dart';
import 'package:ismart/feature/categoryWiseService/dataPack/widget/select_datapack_widget.dart';

class SelectDatapackScreen extends StatelessWidget {
  const SelectDatapackScreen({super.key, this.serviceIdentifier});
  final serviceIdentifier;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DatapackCubit(
          datapackRepository:
              RepositoryProvider.of<DatapackRepository>(context)),
      child: SelectDatapackWidget(
        service: serviceIdentifier,
      ),
    );
  }
}
