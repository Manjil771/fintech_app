import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/common/data_state.dart';
import 'package:ismart/common/util/size_utils.dart';
import 'package:ismart/common/widget/no_data_screen.dart';
import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class GraphWidget extends StatefulWidget {
  const GraphWidget({Key? key}) : super(key: key);

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  List<AccountStatementDtos> statementLists = [];

  // @override
  // void initState() {
  //   statementLists = RepositoryProvider.of<FullStatementRepository>(context)
  //       .getGraphData(days: 90);

  //   statementLists
  //       .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));

  //   statementLists.forEach((element) {
  //     print(element.balance);
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    final _textTheme = _theme.textTheme;
    final _width = SizeUtils.width;
    final _height = SizeUtils.height;
    return BlocBuilder<UtilityPaymentCubit, CommonState>(
      builder: (context, state) {
        if (state is CommonStateSuccess<UtilityResponseData>) {
          final data = state.data.findValue(primaryKey: "balanceList");
          return Column(children: [
            SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                legend: Legend(isVisible: false),
                tooltipBehavior: TooltipBehavior(enable: true),
                series: <ChartSeries<dynamic, String>>[
                  LineSeries<dynamic, String>(
                      dataSource: data,
                      xValueMapper: (dynamic sales, _) =>
                          sales["day"].toString(),
                      yValueMapper: (dynamic sales, _) => sales["balance"],
                      dataLabelSettings: DataLabelSettings(isVisible: false))
                ]),
          ]);
        } else {
          return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              legend: Legend(isVisible: false),
              series: <ChartSeries<dynamic, String>>[
                LineSeries<dynamic, String>(
                    dataSource: [],
                    xValueMapper: (dynamic sales, _) => sales["day"].toString(),
                    yValueMapper: (dynamic sales, _) => sales["balance"],
                    dataLabelSettings: DataLabelSettings(isVisible: false))
              ]);
        }
      },
    );
  }
}

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/feature/statement/fullStatement/model/full_statement_model.dart';
// import 'package:ismart/feature/statement/fullStatement/resources/full_statement_repository.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class GraphWidget extends StatefulWidget {
//   const GraphWidget({Key? key}) : super(key: key);

//   @override
//   State<GraphWidget> createState() => _GraphWidgetState();
// }

// class _GraphWidgetState extends State<GraphWidget> {
//   List<AccountStatementDtos> statementLists = [];

//   // @override
//   // void initState() {
//   //   statementLists = RepositoryProvider.of<FullStatementRepository>(context)
//   //       .getGraphData(days: 90);

//   //   statementLists
//   //       .sort((a, b) => a.transactionDate.compareTo(b.transactionDate));

//   //   statementLists.forEach((element) {
//   //     print(element.balance);
//   //   });

//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return BlocBuilder<UtilityPaymentCubit, CommonState>(
//       builder: (context, state) {
//         if (state is CommonDataFetchSuccess<UtilityResponseData>) {
//           return Container(
//             child: SfCartesianChart(
//               series: <BarSeries<AccountStatementDtos, String>>[
//                 BarSeries<AccountStatementDtos, String>(
//                   // Bind data source
//                   xAxisName: "Date",
//                   yAxisName: "Balance",
//                   dataSource: <AccountStatementDtos>[
//                     ...statementLists,
//                   ],

//                   xValueMapper: (AccountStatementDtos sales, _) =>
//                       sales.transactionDate.toString(),
//                   yValueMapper: (AccountStatementDtos sales, _) =>
//                       sales.balance,
//                 )
//               ],
//             ),
//             child: SfCartesianChart(
//                 // Initialize category axis
//                 primaryXAxis: CategoryAxis(),
//                 series: <LineSeries<SalesData, String>>[
//                   LineSeries<SalesData, String>(
//                       // Bind data source
//                       dataSource: <SalesData>[
//                         ...statementLists
//                             .map((e) => SalesData(
//                                 DateFormat.d()
//                                     .format(e.transactionDate)
//                                     .toString(),
//                                 e.balance))
//                             .toList()
//                       ],
//                       xValueMapper: (SalesData sales, a) => sales.year,
//                       yValueMapper: (SalesData sales, b) => sales.sales)
//                 ]),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }

// class SalesData {
//   SalesData(this.year, this.sales);
//   final String year;
//   final double sales;
// }
