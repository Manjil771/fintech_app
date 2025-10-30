import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ismart/common/constant/env.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/feature/update/cubit/update_cubit.dart';
import 'package:ismart/feature/update/ui/screens/app_update_screens.dart';

class UpdateWrapper extends StatelessWidget {
  final Widget child;
  // final List<String> clientCodesForGlobalApp = [
  //   "EHVNI7CZJ3",
  // ];

  const UpdateWrapper({required this.child});

  @override
  Widget build(BuildContext context) {
    // final clientCode = RepositoryProvider.of<CoOperative>(context).clientCode;
    // final isGlobalApp = clientCodesForGlobalApp.contains(clientCode);
    return BlocListener<UpdateCubit, UpdateState>(
      listener: (context, state) {
        if (state is UpdateAvailableState) {
          NavigationService.push(
            target: AppUpdateScreens(isForceUpdate: state.isForceUpdate),
          );
        }
      },
      child: child,
    );
  }
}
