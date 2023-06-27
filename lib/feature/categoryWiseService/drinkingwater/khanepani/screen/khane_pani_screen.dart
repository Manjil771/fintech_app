import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/cubit/khanepani_cubit.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/resources/khanepani_repository.dart';
import 'package:ismart/feature/categoryWiseService/drinkingwater/khanepani/widget/khane_pani_widget.dart';

class KhanePaniPage extends StatelessWidget {
  const KhanePaniPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => KhanePaniCubit(
        khanePaniRepository:
            RepositoryProvider.of<KhanePaniRepository>(context),
      ),
      child: KhanePaniWidget(),
    );
  }
}
