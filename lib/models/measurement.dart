// ignore_for_file: non_constant_identifier_names
import 'package:goop/models/absModels.dart';
import 'package:goop/models/measurementQuizzlines.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

class MeasurementModel extends AbsModels {
  int id;
  int mission_Id;
  String name;
  int partner_Id; //vendor
  String partner_Name;
  String state;
  DateTime dateStarted;
  DateTime dateFinished;
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
  DateTime create_date;
  int write_Uid;
  String write_Uname;
  DateTime writeDate;
  String kanbanStateLabel;
  String displayName;
  String lastUpdate;

  DateTime dateEnd() {
    DateTime dateEnd =
    create_date.add(Duration(hours: globalConfig.hoursDiffServer));
    // dateEnd = dateEnd.add(Duration(seconds: 5));
    dateEnd = dateEnd.add(Duration(hours: globalConfig.hoursCompletMission));

    return dateEnd;
  }

  List<MeasurementQuizzlinesModel> listMeasurementQuizzlinesModel;

  MeasurementModel({
    this.id,
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
    this.create_date,
    this.write_Uid,
    this.write_Uname,
    this.writeDate,
    this.kanbanStateLabel,
    this.displayName,
    this.lastUpdate,
  });

  MeasurementModel.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    void intListAdd(String fieldName, List<int> list) {
      json[fieldName].forEach((s) => list.add(s as int));
    }

    id = jGetInt('id');
    mission_Id = jGetInt('missions_id', 0);
    name = jGetStr('name');
    partner_Id = jGetInt('partner_id', 0);
    partner_Name = jGetStr('partner_id', 1);

    state = jGetStr('state');
    dateStarted = jGetDate('date_started');
    dateFinished = jGetDate('date_started');
    measurementLatitude = jGetDouble('measurement_latitude');
    measurementLongitude = jGetDouble('measurement_longitude');

    intListAdd('lines_ids', lines_ids);
    intListAdd('quizz_lines_ids', quizz_lines_ids);
    intListAdd('photo_lines_ids', photo_lines_ids);
    intListAdd('price_comparison_lines_ids', price_comparison_lines_ids);

    color = jGetInt('color');
    priority = jGetStr('priority');
    sequence = jGetInt('sequence');
    active = jGetBool('active');
    kanbanState = jGetStr('kanban_state');
    legendPriority = jGetBool('legend_priority');
    legendBlocked = jGetStr('legend_blocked');
    legendDone = jGetStr('legend_done');
    legendNormal = jGetStr('legend_normal');
    legendDoing = jGetStr('legend_doing');
    create_Uid = jGetInt('create_uid', 0);
    create_Uname = jGetStr('create_uid', 1);
    create_date = jGetDate('create_date');
    write_Uid = jGetInt('write_uid', 0);
    write_Uname = jGetStr('write_uid', 1);
    writeDate = jGetDate('write_date');
    kanbanStateLabel = jGetStr('kanban_state_label');
    displayName = jGetStr('display_name');
    lastUpdate = jGetStr('__last_update');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['missions_id'] = this.mission_Id;
    data['name'] = this.name;

    data['partner_id'] = this.partner_Id;

    data['state'] = this.state;
    data['date_started'] = DateToSql(this.dateStarted);
    data['date_finished'] = DateToSql(this.dateFinished);
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
    // data['create_date'] = DateTimeToSql(this.createDate);
    data['write_uid'] = this.write_Uid;
    // data['write_date'] = DateTimeToSql(this.writeDate);
    data['kanban_state_label'] = this.kanbanStateLabel;
    data['display_name'] = this.displayName;
    // data['__last_update'] = this.lastUpdate;
    return data;
  }

  int secondsToCompletMission() {
    return difDateSeconds(DateTime.now(), dateEnd());
  }

  get endTime => DateTime.now().isAfter(dateEnd());
}