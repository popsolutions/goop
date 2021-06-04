
class MeasurementModel {
  int id;
  int mission_Id;
  String name;
  int partner_Id; //vendor
  String partner_Name;
  String state;
  String dateStarted;
  String dateFinished;
  double measurementLatitude;
  double measurementLongitude;

  List<int> lines_ids = [];
  List<int> quizz_lines_ids = [];
  List<int> photo_lines_ids = [];
  List<int> price_comparison_lines_ids = [];
  List<int> missions_Id = [];
  int color;
  String priority;
  int sequence;
  bool active;
  String kanbanState;
  bool legendPriority;
  String legendBlocked;
  String legendDone;
  String legendNormal;
  String legendDoing;
  int create_Uid;
  String create_Uname;
  String createDate;
  int write_Uid;
  String write_Uname;
  String writeDate;
  String kanbanStateLabel;
  String displayName;
  String lastUpdate; //original name "__last_update"

  MeasurementModel({this.id,
    this.mission_Id,
    this.name,
    this.partner_Id,
    this.partner_Name,
    this.state,
    this.dateStarted,
    this.dateFinished,
    this.measurementLatitude,
    this.measurementLongitude,
    this.lines_ids,
    this.quizz_lines_ids,
    this.photo_lines_ids,
    this.price_comparison_lines_ids,
    this.color,
    this.priority,
    this.sequence,
    this.active,
    this.kanbanState,
    this.legendPriority,
    this.legendBlocked,
    this.legendDone,
    this.legendNormal,
    this.legendDoing,
    this.create_Uid,
    this.create_Uname,
    this.createDate,
    this.write_Uid,
    this.write_Uname,
    this.writeDate,
    this.kanbanStateLabel,
    this.displayName,
    this.lastUpdate});

  MeasurementModel.fromJson(Map<String, dynamic> json) {
    void intListAdd(String fieldName, List<int> list){
      json[fieldName].forEach((s) => list.add(s as int));
    }

    String getArrJson(String fieldName, int index){
      if ((json[fieldName] is bool) || (json[fieldName] == null))
        return null;
      else
        return json[fieldName][index].toString();
    }

    int getArrJsonInt(String fieldName, int index){
      if ((json[fieldName] is bool) || (json[fieldName] == null))
        return null;
      else
        return json[fieldName][index];
    }

    id = json['id'];
    mission_Id = getArrJsonInt('missions_id', 0);
    name = json['name'];
    partner_Id =  getArrJsonInt('partner_id', 0);
    partner_Name = getArrJson('partner_id', 1);

    state = json['state'];
    dateStarted = json['date_started'];
    dateFinished = json['date_finished'];
    measurementLatitude = json['measurement_latitude'];
    measurementLongitude = json['measurement_longitude'];

    intListAdd('lines_ids', lines_ids);
    intListAdd('quizz_lines_ids', quizz_lines_ids);
    intListAdd('photo_lines_ids', photo_lines_ids);
    intListAdd('price_comparison_lines_ids', price_comparison_lines_ids);

    color = json['color'];
    priority = json['priority'];
    sequence = json['sequence'];
    active = json['active'];
    kanbanState = json['kanban_state'];
    legendPriority = json['legend_priority'];
    legendBlocked = json['legend_blocked'];
    legendDone = json['legend_done'];
    legendNormal = json['legend_normal'];
    legendDoing = json['legend_doing'];
    create_Uid = getArrJsonInt('create_uid', 0);
    create_Uname = getArrJson('create_uid', 1);
    createDate = json['create_date'];
    write_Uid = getArrJsonInt('write_Uid', 0);
    write_Uname = getArrJson('write_Uid', 1);
    writeDate = json['write_date'];
    kanbanStateLabel = json['kanban_state_label'];
    displayName = json['display_name'];
    lastUpdate = json['__last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['missions_id'] = this.mission_Id;
    data['name'] = this.name;

    data['partner_id'] = this.partner_Id;

    data['state'] = this.state;
    data['date_started'] = this.dateStarted;
    data['date_finished'] = this.dateFinished;
    data['measurement_latitude'] = this.measurementLatitude;
    data['measurement_longitude'] = this.measurementLongitude;

    data['color'] = this.color;
    data['priority'] = this.priority;
    data['sequence'] = this.sequence;
    data['active'] = this.active;
    data['kanban_state'] = this.kanbanState;
    data['legend_priority'] = this.legendPriority;
    data['legend_blocked'] = this.legendBlocked;
    data['legend_done'] = this.legendDone;
    data['legend_normal'] = this.legendNormal;
    data['legend_doing'] = this.legendDoing;

    data['create_uid'] = this.create_Uid;
    data['create_date'] = this.createDate;
    data['write_uid'] = this.write_Uid;
    data['write_date'] = this.writeDate;
    data['kanban_state_label'] = this.kanbanStateLabel;
    data['display_name'] = this.displayName;
    data['__last_update'] = this.lastUpdate;
    return data;



  }
}

// {
// int "id": 74,
// String "name": "MEAS8",
//   "partner_id"
//   "partner_name"
// "state": "done",
// "date_started": "2021-05-02",
// "date_finished": "2021-05-02",
// "measurement_latitude": 434.0,
// "measurement_longitude": 121.0,
//   "google_map_measurement_lat":
//   "google_map_measurement_lng":
//   "google_map_measurement_zoom":
// "lines_ids": [],
// "quizz_lines_ids": [],
// "photo_lines_ids": [],
// "price_comparison_lines_ids": [],
//
//   "missions_id": [
//
// "color": 0,
// "priority": "0",
// "sequence": 10,
// "active": true,
// "kanban_state": "draft",
// "legend_priority": false,
// "legend_blocked": "Ready",
// "legend_done": "Done",
// "legend_normal": "Pending",
// "legend_doing": "In Progress",
//
//   "create_uid": [
//   "create_uname": [
// "create_date": "2021-05-31 21:10:12",
//   "write_uid": [
//   "write_uname": [
//
// "write_date": "2021-05-31 21:12:27",
// "kanban_state_label": "Pending",
// "display_name": "MEAS8",
// "__last_update": "2021-05-31 21:12:27"
//
//
// }
//
