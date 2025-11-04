import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ismart/common/constant/env.dart';
import 'package:ismart/feature/dashboard/notice/widget/notice_widget.dart';
import 'package:ismart/feature/utility_payment/cubit/utility_payment_cubit.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UtilityPaymentCubit(
          utilityPaymentRepository: RepositoryProvider.of(context))
        ..fetchDetails(
          serviceIdentifier: "",
          accountDetails: {"date": ""},
          apiEndpoint: "api/notices",
          extraHeaders: {
            "client": RepositoryProvider.of<CoOperative>(context).clientCode
          },
        ),
      child: const NoticeWidget(),
    );
  }
}
