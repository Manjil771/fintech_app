import 'package:ismart/feature/utility_payment/enums/topup_type.dart';

class TopUpUtils {
  String getTopUpServiceType({required TopupType type}) {
    if (type == TopupType.NTCPostpaid) {
      return "ntc_postpaid_topup";
    } else if (type == TopupType.NTCPrepaid) {
      return "ntc_prepaid_topup";
    } else if (type == TopupType.Ncell) {
      return "ncell_prepaid_topup";
    } else {
      return "";
    }
  }
}
