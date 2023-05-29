import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/customerDetail/cubit/customer_detail_cubit.dart';
import 'package:ismart/feature/customerDetail/customer_Detail_widget.dart';
import 'package:ismart/feature/customerDetail/resource/customer_detail_repository.dart';

class CustomerDEtailScreen extends StatelessWidget {
  const CustomerDEtailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => CustomerDetailCubit(
        customerDetailRepository:
            RepositoryProvider.of<CustomerDetailRepository>(context),
      ),
      child: CustomerDEtailWidget(),
    );
  }
}
