
import 'package:goop/models/activity.dart';
import 'package:goop/models/measurement.dart';
import 'package:goop/models/user_profile.dart';

class MissionModel {
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

  List<Activity> listActivity = <Activity>[];
  MeasurementModel measurementModel;

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

  factory MissionModel.fromJson(Map<String, dynamic> map) {
    return MissionModel(
      id: valueOrNull(map['id']),
      name: valueOrNull(map['name']),
      partnerId: valueOrNull(map['partner_id'][0]),
      establishmentId: valueOrNull(map['establishment_id'][0]),
      createByUserId: valueOrNull(map['create_by_user_id'][0]),
      measurementCount: valueOrNull(map['measurement_count']),
      instructions: valueOrNull(map['instructions']),
      missionState: valueOrNull(map['state']),
      address: valueOrNull(map['address']),
      dateCreated: valueOrNull(map['date_created']),
      dateFinished: valueOrNull(map['date_finished']),
      limit: valueOrNull(map['limit']),
      subject: valueOrNull(map['subject']),
      price: valueOrNull(map['price']),
      time: valueOrNull(map['time']),
      priority: valueOrNull(map['priority']),
      reward: valueOrNull(map['reward']),
      typeMission: valueOrNull(map['type_mission']),
      scores: valueOrNull(map['scores']),
    );
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

  toString([String separator = '\n']){
    return
    'id: ' + (id.toString() ?? '') + separator +
    'name: ' + (name.toString() ?? '') + separator +
    'subject: ' + (subject.toString() ?? '') + separator +
    'partnerId: ' + (partnerId.toString() ?? '') + separator +
    'establishmentId: ' + (establishmentId.toString() ?? '') + separator +
    'measurementCount: ' + (measurementCount.toString() ?? '') + separator +
    'createByUserId: ' + (createByUserId.toString() ?? '') + separator +
    'limit: ' + (limit.toString() ?? '') + separator +
    'priority: ' + (priority.toString() ?? '') + separator +
    'scores: ' + (scores.toString() ?? '') + separator +
    'reward: ' + (reward.toString() ?? '') + separator +
    'typeMission: ' + (typeMission.toString() ?? '') + separator +
    'instructions: ' + (instructions.toString() ?? '') + separator +
    'missionState: ' + (missionState.toString() ?? '') + separator +
    'address: ' + (address.toString() ?? '') + separator +
    'dateCreated: ' + (dateCreated.toString() ?? '') + separator +
    'dateFinished: ' + (dateFinished.toString() ?? '') + separator +
    'price: ' + (price.toString() ?? '') + separator +
    'time: ' + (time.toString() ?? '');
  }

}
