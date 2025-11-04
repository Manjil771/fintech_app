import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/profile/widget/profile_picture_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

class ProfilePictureScreen extends StatelessWidget {
  final String imageUrl;
  final String gender;

  const ProfilePictureScreen(
      {super.key, required this.imageUrl, required this.gender});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository:
              RepositoryProvider.of<UtilityPaymentRepository>(context)),
      child: ProfilePictureWidget(
        imageUrl: imageUrl,
        gender: gender,
      ),
    );
  }
}
