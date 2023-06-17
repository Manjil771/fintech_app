import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/statement/fullStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';
import 'package:ismart/feature/statement/fullStatement/ui/widget/full_statement_widget.dart';
import 'package:ismart/feature/statement/miniStatement/cubit/mini_statement_cubit.dart';
import 'package:ismart/feature/statement/miniStatement/resources/mini_statement_repository.dart';
import 'package:ismart/feature/statement/miniStatement/ui/widget/mini_statement_widget.dart';

class FullStatementPage extends StatefulWidget {
  @override
  State<FullStatementPage> createState() => _FullStatementPageState();
}

class _FullStatementPageState extends State<FullStatementPage> {
  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocProvider(
      create: (context) => FullStatementCubit(
        fullStatementRepository:
            RepositoryProvider.of<FullStatementRepository>(context),
      ),
      child: FullStatementWidget(),
    );
  }
}
