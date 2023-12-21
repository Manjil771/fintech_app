import 'package:fluttercontactpicker/fluttercontactpicker.dart'
    as flutter_contact_picker;
import 'package:ismart/common/navigation/navigation_service.dart';
import 'package:ismart/common/util/snackbar_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactUtils {
  static Future<String?> get pickContact async {
    try {
      final _contactPermission = await Permission.contacts.request();
      if (_contactPermission.isGranted) {
        final _contact =
            await flutter_contact_picker.FlutterContactPicker.pickPhoneContact(
                askForPermission: true);
        return _contact.phoneNumber?.number;
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
