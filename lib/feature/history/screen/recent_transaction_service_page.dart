import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/history/cubit/receipt_download_cubit.dart';
import 'package:ismart/feature/history/cubit/recent_transaction_cubit.dart';
import 'package:ismart/feature/history/models/recent_transaction_model.dart';
import 'package:ismart/feature/history/resources/recent_transaction_repository.dart';
import 'package:ismart/feature/history/widget/recent_transaction_service_widget.dart';
import 'package:ismart/feature/history/widget/recent_transaction_widget.dart';

class RecentTransactionServiceScreen extends StatefulWidget {
  final String serviceCategoryId;
  final String associatedId;
  final String? service;
  final Function(RecentTransactionModel) onRecentTransactionPressed;

  const RecentTransactionServiceScreen(
      {Key? key,
      required this.serviceCategoryId,
      required this.associatedId,
      this.service,
      required this.onRecentTransactionPressed})
      : super(key: key);

  @override
  State<RecentTransactionServiceScreen> createState() =>
      _RecentTransactionServiceScreenState();
}

class _RecentTransactionServiceScreenState
    extends State<RecentTransactionServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RecentTransactionCubit(
            recentTransactionRepository:
                RepositoryProvider.of<RecentTransactionRepository>(context),
          ),
        ),
        BlocProvider(
          create: (context) => TransactionDownloadCubit(
            recentTransactionRepository:
                RepositoryProvider.of<RecentTransactionRepository>(context),
          ),
        )
      ],
      child: RecentTransactionServiceWidget(
        onRecentTransactionPressed: widget.onRecentTransactionPressed,
        service: widget.service ?? "SERVICE",
        associatedId: widget.associatedId,
        serviceCategoryId: widget.serviceCategoryId,
      ),
    );
  }
}
