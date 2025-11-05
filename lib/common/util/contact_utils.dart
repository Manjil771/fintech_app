import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactUtils {
  static Future<String?> get pickContact async {
    final FlutterNativeContactPicker _contactPicker =
        FlutterNativeContactPicker();

    try {
      final _contactPermission = await Permission.contacts.request();

      if (_contactPermission.isGranted) {
        final _contact = await _contactPicker.selectContact();
        print(
            '---------------------------This is picked number : ${_contact?.selectedPhoneNumber}------------------------------------');
        final firstValidPhoneNumber = _contact?.phoneNumbers?.firstWhere(
          (number) => number.trim().isNotEmpty,
        );

        return firstValidPhoneNumber ?? _contact?.selectedPhoneNumber ?? "";
      } else {
        SnackBarUtils.showErrorBar(
          context: NavigationService.context,
          message: "Contact permission not available.",
        );
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
