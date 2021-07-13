import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/absModels.dart';
import 'package:goop/models/activity.dart';
import 'package:goop/models/establishment.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/services/mission/mission_service.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';


class MissionModel extends AbsModels {
  int id;
  String name;
  String subject;
  int partnerId;
  int establishmentId;
  int measurementCount;
  int createByUserId;
  int limit;
  int priority;
  double scores;
  double reward;
  String typeMission;
  String instructions;
  String missionState;
  String address;
  String dateCreated;
  String dateFinished;
  double price;
  String time;
  bool inProgress = false;
  bool inProgressOrDone = false;
  MissionStatus _status = MissionStatus.Ordered;
  String timeToCompletMission = '';
  bool secondsRedMissionTime = false;

  bool activityAllDoneIsLoadlistActivity = false;

  List<Activity> listActivity = <Activity>[];
  MeasurementModel _measurementModel;
  EstablishmentModel establishmentModel;

  MissionService missionService = new MissionService(Odoo());

  MissionModel({
    this.id,
    this.partnerId,
    this.establishmentId,
    this.createByUserId,
    this.name,
    this.missionState,
    this.instructions,
    this.address,
    this.typeMission,
    this.measurementCount,
    this.dateCreated,
    this.dateFinished,
    this.limit,
    this.reward,
    this.priority,
    this.scores,
    this.subject,
    this.price,
    this.time,
  });

  MissionModel.fromJson(Map<String, dynamic> map) {
    currentJson = map;

    id = jGetInt('id');
    name = jGetStr('name');
    partnerId = jGetInt('partner_id', 0);
    establishmentId = jGetInt('establishment_id', 0);
    createByUserId = jGetInt('create_by_user_id', 0);
    measurementCount = jGetInt('measurement_count');
    instructions = jGetStr('instructions');
    missionState = jGetStr('state');
    address = jGetStr('address');
    dateCreated = jGetStr('date_created');
    dateFinished = jGetStr('date_finished');
    limit = jGetInt('limit');
    subject = jGetStr('subject');
    price = jGetDouble('price');
    time = jGetStr('time');
    priority = jGetInt('priority');
    reward = jGetDouble('reward');
    typeMission = jGetStr('type_mission');
    scores = jGetDouble('scores');
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (subject != null) 'subject': subject,
      if (partnerId != null) 'partnerId': partnerId,
      if (establishmentId != null) 'establishmentId': establishmentId,
      if (measurementCount != null) 'measurementCount': measurementCount,
      if (createByUserId != null) 'createByUserId': createByUserId,
      if (limit != null) 'limit': limit,
      if (priority != null) 'priority': priority,
      if (scores != null) 'scores': scores,
      if (reward != null) 'reward': reward,
      if (typeMission != null) 'typeMission': typeMission,
      if (instructions != null) 'instructions': instructions,
      if (missionState != null) 'missionState': missionState,
      if (address != null) 'address': address,
      if (dateCreated != null) 'dateCreated': dateCreated,
      if (dateFinished != null) 'dateFinished': dateFinished,
      if (price != null) 'price': price,
      if (time != null) 'time': time,
    };
  }

  toString([String separator = '\n']) {
    return 'id: ' +
        (id.toString() ?? '') +
        separator +
        'name: ' +
        (name.toString() ?? '') +
        separator +
        'subject: ' +
        (subject.toString() ?? '') +
        separator +
        'partnerId: ' +
        (partnerId.toString() ?? '') +
        separator +
        'establishmentId: ' +
        (establishmentId.toString() ?? '') +
        separator +
        'measurementCount: ' +
        (measurementCount.toString() ?? '') +
        separator +
        'createByUserId: ' +
        (createByUserId.toString() ?? '') +
        separator +
        'limit: ' +
        (limit.toString() ?? '') +
        separator +
        'priority: ' +
        (priority.toString() ?? '') +
        separator +
        'scores: ' +
        (scores.toString() ?? '') +
        separator +
        'reward: ' +
        (reward.toString() ?? '') +
        separator +
        'typeMission: ' +
        (typeMission.toString() ?? '') +
        separator +
        'instructions: ' +
        (instructions.toString() ?? '') +
        separator +
        'missionState: ' +
        (missionState.toString() ?? '') +
        separator +
        'address: ' +
        (address.toString() ?? '') +
        separator +
        'dateCreated: ' +
        (dateCreated.toString() ?? '') +
        separator +
        'dateFinished: ' +
        (dateFinished.toString() ?? '') +
        separator +
        'price: ' +
        (price.toString() ?? '') +
        separator +
        'time: ' +
        (time.toString() ?? '');
  }

  set measurementModel(MeasurementModel measurementModel) {
    this._measurementModel = measurementModel;
    updateStatus();
  }

  void updateStatus() {
    MissionStatus newStatus;

    if (this._measurementModel == null) {
      newStatus = MissionStatus.Ordered;
    } else {
      if ((_measurementModel.state == 'draft') ||
          (_measurementModel.state == 'ordered'))
        newStatus = MissionStatus.Ordered;
      else if (_measurementModel.state == 'doing')
        newStatus = MissionStatus.InProgress;
      else if (_measurementModel.state == 'repproved')
        newStatus = MissionStatus.Repproved;
      else
        newStatus = MissionStatus.Closed;

      if ((newStatus == MissionStatus.Ordered) ||
          (newStatus == MissionStatus.InProgress)) {
        if ((this.activityAllDone()) == true)
          newStatus = MissionStatus.Done;
        else if (this.endTime()) newStatus = MissionStatus.EndTime;
      }
    }

    if (this.status != newStatus) this.status = newStatus;
  }

  MeasurementModel get measurementModel => this._measurementModel;

  String getTimeToCompletMission() {
    if (_measurementModel == null)
      return '';
    else {
      int secondsToCompletMission = _measurementModel.secondsToCompletMission();

      if ((secondsToCompletMission <= 0) &
          (this.status == MissionStatus.InProgress)) updateStatus();

      secondsRedMissionTime =
          (secondsToCompletMission < globalConfig.secondsRedMissionTime);

      return convertSecondsToHHMMSS(secondsToCompletMission);
    }
  }

  MissionStatus get status => _status;

  String statusText(){
    if (status == MissionStatus.Ordered) return 'Aguardando';
    if (status == MissionStatus.InProgress) return 'Em execução';
    if (status == MissionStatus.EndTime) return 'Tempo Esgotado';
    if (status == MissionStatus.Done) return 'Concluída';
    if (status == MissionStatus.Closed) return 'Fechada';
  }

  set status(MissionStatus value) {
    _status = value;
    inProgress = _status == MissionStatus.InProgress;
    inProgressOrDone = (_status == MissionStatus.InProgress) ||
        (_status == MissionStatus.Done) ||
        (_status == MissionStatus.Closed);
  }

  void settimeToCompletMission() {
    timeToCompletMission = getTimeToCompletMission();
  }

  bool activityAllDone() => listActivity.length == activityAmoutDone();

  bool endTime() =>
      (_measurementModel == null) ? false : (_measurementModel.endTime);

  int activityAmoutDone() {
    int amountDone = 0;
    listActivity.forEach((element) {
      if (element.isChecked) amountDone += 1;
    });

    return amountDone;
  }
}

enum MissionStatus {
  Ordered,
  InProgress,
  EndTime,
  Done,
  Closed,
  Repproved
}
