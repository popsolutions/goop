import 'package:goop/models/absModels.dart';
import 'package:goop/utils/utils.dart';


class MeasurementPriceComparisonLinesModel extends AbsModels {
  int id;
  int measurement_id;
  String comparison_id;
  int product_id;
  String product_name;
  double price;
  String photo;
  int create_uid;
  DateTime create_date;
  int write_uid;
  DateTime write_date;
  String display_name;

  MeasurementPriceComparisonLinesModel(
      {this.id,
      this.measurement_id,
      this.comparison_id,
      this.product_id,
      this.price,
      this.photo,
      this.create_uid,
      this.create_date,
      this.write_uid,
      this.write_date,
      this.display_name});

  MeasurementPriceComparisonLinesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    measurement_id = json['measurement_id'][0];
    comparison_id = JsonGet.Str(json, 'comparison_id');
    product_id = json['product_id'][0];
    product_name = json['product_id'][1];
    price = json['price'];
    photo = json['photo'];
    create_uid = json['create_uid'][0];
    create_date = DateTime.parse(json['create_date']);
    write_uid = json['write_uid'][0];
    write_date =  DateTime.parse(json['write_date']);
    display_name = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['measurement_id'] = this.measurement_id;
    // data['comparison_id'] = this.comparison_id;
    data['product_id'] = this.product_id;
    // data['product_name'] = this.product_name;
    data['price'] = this.price;
    data['photo'] = this.photo;
    data['create_uid'] = this.create_uid;
    // data['create_date'] = DateToSql(this.create_date);
    data['write_uid'] = this.write_uid;
    // data['write_date'] = this.write_date;
    data['display_name'] = this.display_name;

    return data;
  }


}