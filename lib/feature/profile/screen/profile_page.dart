import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/feature/profile/resources/cubits/image_upload_cubit.dart';
import 'package:ismart/feature/profile/resources/image_upload_repository.dart';
import 'package:ismart/feature/profile/widget/profile_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ImageUploadCubit(
        imageUploadRepository:
            RepositoryProvider.of<ImageUploadRepository>(context),
      ),
      child: const ProfileWidget(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/constant/env.dart';
// import 'package:ismart/common/util/size_utils.dart';
// import 'package:ismart/feature/profile/resources/cubits/image_upload_cubit.dart';
// import 'package:ismart/feature/profile/resources/image_upload_repository.dart';
// import 'package:ismart/feature/profile/widget/profile_widget.dart';
// import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';
// import 'package:ismart/feature/utility_payment/resources/utility_payment_repository.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({Key? key}) : super(key: key);

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     final _theme = Theme.of(context);
//     final _textTheme = _theme.textTheme;
//     final _width = SizeUtils.width;
//     final _height = SizeUtils.height;
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => ImageUploadCubit(
//             imageUploadRepository:
//                 RepositoryProvider.of<ImageUploadRepository>(context),
//           ),
//         ),
//         BlocProvider(
//           create: (context) => UtilityPaymentCubit(
//               utilityPaymentRepository:
//                   RepositoryProvider.of<UtilityPaymentRepository>(context))
//             ..fetchDetails(
//                 serviceIdentifier: "",
//                 accountDetails: {},
//                 apiEndpoint:
//                     "appcontactdetail/get/${RepositoryProvider.of<CoOperative>(context).clientCode}"),
//         )
//       ],
//       child: const ProfileWidget(),
//     );
//   }
// }
