import 'dart:convert';

import 'package:goop/models/absModels.dart';

import 'mission.dart';

class MissionDto extends AbsModels {
  int id;
  String name;
  String subject;
  int partnerId;
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
  int establishmentId;
  String nameEstablishment;
  String addressEstablishment;
  String latitude;
  String longitude;

  MissionModel missionModel;

  MissionDto(
      {this.id,
      this.name,
      this.subject,
      this.partnerId,
      this.establishmentId,
      this.measurementCount,
      this.createByUserId,
      this.limit,
      this.priority,
      this.scores,
      this.reward,
      this.typeMission,
      this.instructions,
      this.missionState,
      this.address,
      this.dateCreated,
      this.dateFinished,
      this.price,
      this.time,
      this.nameEstablishment,
      this.addressEstablishment,
      this.latitude,
      this.longitude,
      this.missionModel});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'partnerId': partnerId,
      'establishmentId': establishmentId,
      'measurementCount': measurementCount,
      'createByUserId': createByUserId,
      'limit': limit,
      'priority': priority,
      'scores': scores,
      'reward': reward,
      'typeMission': typeMission,
      'instructions': instructions,
      'missionState': missionState,
      'address': address,
      'dateCreated': dateCreated,
      'dateFinished': dateFinished,
      'price': price,
      'time': time,
      'nameEstablishment': nameEstablishment,
      'addressEstablishment': addressEstablishment,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  MissionDto.fromMap(Map<String, dynamic> map) {
    currentJson = map;

    id = jGetInt('id');
    name = jGetStr('name');
    subject = jGetStr('subject');
    partnerId = jGetInt('partnerId');
    establishmentId = jGetInt('establishmentId');
    measurementCount = jGetInt('measurementCount');
    createByUserId = jGetInt('createByUserId');
    limit = jGetInt('limit');
    priority = jGetInt('priority');
    scores = jGetDouble('scores');
    reward = jGetDouble('reward');
    typeMission = jGetStr('typeMission');
    instructions = jGetStr('instructions');
    missionState = jGetStr('missionState');
    address = jGetStr('address');
    dateCreated = jGetStr('dateCreated');
    dateFinished = jGetStr('dateFinished');
    price = jGetDouble('price');
    time = jGetStr('time');
    nameEstablishment = jGetStr('nameEstablishment');
    addressEstablishment = jGetStr('addressEstablishment');
    latitude = jGetStr('latitude');
    longitude = jGetStr('longitude');
  }

  String toJson() => json.encode(toMap());

  factory MissionDto.fromJson(String source) =>
      MissionDto.fromMap(json.decode(source));
}
