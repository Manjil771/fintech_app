import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/profile/contactUsProfile/widget/contact_us_profile_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class ContactUsWrapper extends StatelessWidget {
  final String latitude;
  final String longitude;
  final List details;
  const ContactUsWrapper(
      {super.key,
      required this.details,
      required this.latitude,
      required this.longitude});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => UtilityPaymentCubit(
            utilityPaymentRepository:
                RepositoryProvider.of<UtilityPaymentRepository>(context))
          ..fetchDetails(
              serviceIdentifier: '',
              accountDetails: {},
              extraHeaders: {
                "client": RepositoryProvider.of<CoOperative>(
                        NavigationService.context)
                    .clientCode,
              },
              apiEndpoint: 'get/productapp'),
        child: ContactUsProfileWidget(
          latitude: latitude,
          longitude: longitude,
          details: details,
        ));
  }
}
