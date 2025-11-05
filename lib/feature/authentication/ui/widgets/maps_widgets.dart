// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:ismart/common/common/data_state.dart';
// import 'package:ismart/common/widget/no_data_screen.dart';
// import 'package:ismart/common/widget/page_wrapper.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/models/utility_response_data.dart';

// class MapsWidgets extends StatelessWidget {
//   const MapsWidgets({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PageWrapper(
//       body: BlocBuilder<UtilityPaymentCubit, CommonState>(
//         builder: (context, state) {
//           if (state is CommonStateSuccess<UtilityResponseData>) {
//             final data = state.data.details;
//             final values = List.from(data.firstOrNull?.value ?? []);
//             values.removeWhere((val) {
//               int _currentIndex = values.indexOf(val);
//               final _testLat =
//                   double.tryParse("${val['latitude'] ?? "0"}") ?? 0;
//               final _testLong =
//                   double.tryParse("${val['longitude'] ?? "0"}") ?? 0;

//               if ((_testLat < -90 || _testLat > 90) ||
//                   (_testLong < -180 || _testLong > 180)) {
//                 return true;
//               }
//               return false;
//             });

//             if (values.isNotEmpty) {
//               List<Marker> markers = [];

//               for (var item in values) {
//                 final branch = item as Map<String, dynamic>;
//                 final lat = branch['latitude'];
//                 final lng = branch['longitude'];
//                 final name = branch['name'] ?? 'No Name';

//                 if (lat != null && lng != null) {
//                   markers.add(
//                     Marker(
//                       width: 80,
//                       height: 80,
//                       point: LatLng(double.tryParse(lat.toString()) ?? 0,
//                           double.tryParse(lng.toString()) ?? 0),
//                       builder: (ctx) => const Icon(
//                         Icons.location_on,
//                         color: Colors.red,
//                         size: 40,
//                       ),
//                     ),
//                   );
//                 }
//               }

//               // Center map on first marker or default location
//               final center = markers.isNotEmpty
//                   ? markers[0].point
//                   : LatLng(27.7172, 85.3240); // Kathmandu default

//               return FlutterMap(
//                 options: MapOptions(
//                   center: center,
//                   zoom: 13.0,
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     subdomains: const ['a', 'b', 'c'],
//                     userAgentPackageName: 'com.example.app',
//                   ),
//                   MarkerLayer(markers: markers),
//                 ],
//               );
//             } else {
//               return const NoDataScreen(
//                 title: "No Branches Found",
//                 details: "No location data was returned from the server.",
//               );
//             }
//           }

//           return const NoDataScreen(
//             title: "No Data",
//             details: "No data available to display.",
//           );
//         },
//       ),
//     );
//   }
// }
