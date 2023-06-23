import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  List<AccountStatementDtos> statementLists = [];

  @override
  void initState() {
    statementLists = RepositoryProvider.of<FullStatementRepository>(context)
        .getGraphData(days: 90);

    statementLists
        .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));

    statementLists.forEach((element) {
      print(element.balance);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return Container(
      // child: SfCartesianChart(
      //   series: <BarSeries<AccountStatementDtos, String>>[
      //     BarSeries<AccountStatementDtos, String>(
      //       // Bind data source
      //       xAxisName: "Date",
      //       yAxisName: "Balance",
      //       dataSource: <AccountStatementDtos>[
      //         ...statementLists,
      //       ],

      //       xValueMapper: (AccountStatementDtos sales, _) =>
      //           sales.transactionDate.toString(),
      //       yValueMapper: (AccountStatementDtos sales, _) => sales.balance,
      //     )
      //   ],
      // ),
      child: SfCartesianChart(
          // Initialize category axis
          primaryXAxis: CategoryAxis(),
          series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
                // Bind data source
                dataSource: <SalesData>[
                  ...statementLists
                      .map((e) => SalesData(
                          DateFormat.d().format(e.transactionDate).toString(),
                          e.balance))
                      .toList()
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales)
          ]),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
