import 'package:goop/services/constants.dart';

import 'modelsAbs.dart';

class AccountInvoiceModel extends ModelsAbs{
  String modelName = Strings.accountInvoice;

  int id;
  String name;
  DateTime date_invoice;
  DateTime date_due;
  String number;
  String reference;
  String origin;
  String type;
  String state;
  int partner_id;
  String partner_name;
  double amount_untaxed;
  double amount_tax_signed;
  double amount_untaxed_invoice_signed;
  double amount_untaxed_signed;
  double amount_tax;
  double amount_total;
  double amount_total_signed;
  double amount_total_company_signed;
  double residual_signed;
  bool reconciled;
  int user_id;
  String user_name;
  String vendor_display_name;
  bool active;
  int create_uid;
  String create_name;
  DateTime create_date;
  int write_uid;
  String write_name;
  DateTime write_date;
  String operation_type;
  String key;
  String state_edoc;
  String cnpj_cpf;


  AccountInvoiceModel.name(this.modelName, this.id, this.name, this.origin, this.type, this.state, this.partner_id, this.partner_name,
      this.amount_untaxed, this.amount_untaxed_signed, this.amount_tax, this.amount_total, this.amount_total_signed,
      this.amount_total_company_signed, this.reconciled, this.user_id, this.user_name, this.vendor_display_name, this.active,
      this.create_uid, this.create_name, this.create_date, this.write_uid, this.write_name, this.write_date, this.operation_type, this.key,
      this.state_edoc, this.cnpj_cpf);

  String fieldsAll() => '"id", "name", "date_invoice", "date_due", "number",  "reference", "origin", "type", "state", "partner_id",  "partner_name", "amount_untaxed", "amount_tax_signed", "amount_untaxed_invoice_signed", "amount_untaxed_signed",  "amount_tax", "amount_total", "amount_total_signed", "amount_total_company_signed", "residual_signed",  "reconciled", "user_id", "user_name", "vendor_display_name", "active",  "create_uid", "create_name", "create_date", "write_uid", "write_name",  "write_date", "operation_type", "key", "issuer", "state_edoc", "cnpj_cpf"';
  String fieldsOdooAccountProviderScreen() => '"vendor_display_name", "date_invoice", "number", "reference", "date_due", "origin", "amount_untaxed_invoice_signed", "amount_tax_signed", "amount_total_signed", "residual_signed", "state"';

  AccountInvoiceModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    id = jGetInt('id');
    name = jGetStr('name');
    origin = jGetStr('origin');
    type = jGetStr('type');
    state = jGetStr('state');
    partner_id = jGetInt('partner_id', 0);
    partner_name = jGetStr('partner_id', 1);
    amount_untaxed = jGetDouble('amount_untaxed');
    amount_untaxed_signed = jGetDouble('amount_untaxed_signed');
    amount_tax = jGetDouble('amount_tax');
    amount_total = jGetDouble('amount_total');
    amount_total_signed = jGetDouble('amount_total_signed');
    amount_total_company_signed = jGetDouble('amount_total_company_signed');
    reconciled = jGetBool('reconciled');
    user_id = jGetInt('user_id', 0);
    user_name = jGetStr('user_id', 1);
    vendor_display_name = jGetStr('vendor_display_name');
    active = jGetBool('active');
    create_uid = jGetInt('create_uid', 0);
    create_name = jGetStr('create_uid', 1);
    create_date = jGetDate('create_date');
    write_uid = jGetInt('write_uid', 0);
    write_name = jGetStr('write_uid', 1);
    write_date = jGetDate('write_date');
    operation_type = jGetStr('operation_type');
    key = jGetStr('key');
    state_edoc = jGetStr('state_edoc');
    cnpj_cpf = jGetStr('cnpj_cpf');
  }
}
