import 'package:goop/services/absService.dart';
import 'package:goop/utils/global.dart';

class GenericService extends absService {
  Future<List> getCarteira() async {
    final List listJson = await searchReadGen('account.invoice', filter: [
      [
        "partner_id",
        "in",
        [globalServiceNotifier.currentUser.partnerId]
      ]
    ], fields: [
      "date_invoice",
      "reference",
      "amount_total_signed",
      "state"
    ]);

    return listJson;
  }
}
