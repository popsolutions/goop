import 'package:goop/utils/utils.dart';

class Activity {
  int id;
  int product_id;
  String name;
  int mission_id;
  String create_date;
  String write_date;
  String display_name;
  String last_update; // original name "__last_update"
  String activityType; //Quizz, Photo, Price_Comparison

  Activity(
      {this.id,
      this.product_id,
      this.name,
      this.mission_id,
      this.create_date,
      this.write_date,
      this.display_name,
      this.last_update,
      this.activityType});

  factory Activity.fromJson(Map<String, dynamic> map) {
    print('x');

    int mission_id = 0;

    if (map['mission_id'] != null)
      mission_id = map['mission_id'][0];

    if (map['missions_id'] != null)
      mission_id = map['missions_id'][0];


    // if ((map['mission_id'] != null) && (map['mission_id'][0] is int))
    //   mission_id = map['mission_id'][0];
    //
    // if ((map['missions_id'] != null) && (!(map['missions_id'] is bool)))
    //   mission_id = map['missions_id'][0];

    if (mission_id == 0)
      return null;

    return Activity(
        id: valueOrNull(map['id']),
        product_id: valueOrNull((map['product_id'] == null) ? 0 : map['product_id'][0]),
        name: valueOrNull(map['name']),
        mission_id: mission_id,
        create_date: valueOrNull(map['create_date']),
        write_date: valueOrNull(map['write_date']),
        display_name: valueOrNull(map['display_name']),
        last_update: valueOrNull(map['last_update']),
        activityType: null);
  }
}
