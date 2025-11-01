// import 'dart:io';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:in_app_update/in_app_update.dart';
// import 'package:ismart/common/util/device_utils.dart';
// import 'package:ismart/common/util/in_app_update_utils.dart';
// import 'package:ismart/feature/update/model/app_update.dart';
// import 'package:ismart/feature/update/utils/update_utils.dart';

// part 'update_state.dart';

// class UpdateCubit extends Cubit<UpdateState> {
//   UpdateCubit() : super(UpdateInitial());

//   showUpdate(AppUpdate appupdate) async {
//     emit(UpdateLoading());
//     final _version = await DeviceUtils.getAppVersion;
//     final _isUpdateAvaile = UpdateUtils.isUpdateAvailable(
//         currentVersion: _version, appUpdate: appupdate);
//     if (_isUpdateAvaile) {
//       final _isForceUpdate = UpdateUtils.isForceUpdateAvailable(
//           currentVersion: _version, appUpdate: appupdate);
//       if (_isForceUpdate == false && Platform.isAndroid) {
//         _updateInAppUpdate();
//       } else {
//         emit(UpdateAvailableState(isForceUpdate: _isForceUpdate));
//       }
//     } else {
//       final bool _res = await InAppUpdateUtils.isUpdateAvailable;
//       if (_res) {
//         if (Platform.isAndroid) {
//           _updateInAppUpdate();
//         } else {
//           emit(const UpdateAvailableState(isForceUpdate: false));
//         }
//       }
//     }
//   }

//   _updateInAppUpdate() async {
//     if (Platform.isAndroid) {
//       final _appUpdateInfo = await InAppUpdate.checkForUpdate();
//       if (_appUpdateInfo.immediateUpdateAllowed) {
//         final _ = await InAppUpdate.performImmediateUpdate();
//       } else if (_appUpdateInfo.flexibleUpdateAllowed) {
//         final _appUpdateResult = await InAppUpdate.startFlexibleUpdate();
//         if (_appUpdateResult == AppUpdateResult.success) {
//           final _ = await InAppUpdate.completeFlexibleUpdate();
//         }
//       }
//     }
//   }
// }
