// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/feature/categoryWiseService/kalimati_rent_service/widgets/kalimati_details_widget.dart';
// import 'package:ismart/feature/dashboard/homePage/homePageTabbar/servicesTab/model/category_model.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';
// import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

// class KalimatiRentDetailPage extends StatelessWidget {
//   final ServiceList service;
//   final UtilityResponseData data;
//   const KalimatiRentDetailPage(
//       {super.key, required this.data, required this.service});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UtilityPaymentCubit(
//         utilityPaymentRepository:
//             RepositoryProvider.of<UtilityPaymentRepository>(context),
//       ),
//       child: KalimatiDetailsWidget(data: data, service: service),
//     );
//   }
// }
