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
}
