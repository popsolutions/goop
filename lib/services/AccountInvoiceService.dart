import 'package:goop/models/accountInvoice.dart';
import 'package:goop/services/absService.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/utils/global.dart';

class AccountInvoiceService extends absService{
  String modelName = Strings.accountInvoice;

  Future<List<AccountInvoiceModel>> getAccountInvoiceModelCurrentUser() async {
    final response = await odoo.searchRead(
      modelName,
      [
        ["partner_id", "in", [globalcurrentUser.partnerId]]
      ],
      [],
    );

    final List json = response.getRecords();
    final listAccountInvoiceModel = json.map((e) => AccountInvoiceModel.fromJson(e)).toList();
    return listAccountInvoiceModel;
  }
}