import 'dart:convert';

import 'mission.dart';

class MissionDto {
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

  factory MissionDto.fromMap(Map<String, dynamic> map) {
    return MissionDto(
      id: map['id'],
      name: map['name'],
      subject: map['subject'],
      partnerId: map['partnerId'],
      establishmentId: map['establishmentId'],
      measurementCount: map['measurementCount'],
      createByUserId: map['createByUserId'],
      limit: map['limit'],
      priority: map['priority'],
      scores: map['scores'],
      reward: map['reward'],
      typeMission: map['typeMission'],
      instructions: map['instructions'],
      missionState: map['missionState'],
      address: map['address'],
      dateCreated: map['dateCreated'],
      dateFinished: map['dateFinished'],
      price: map['price'],
      time: map['time'],
      nameEstablishment: map['nameEstablishment'],
      addressEstablishment: map['addressEstablishment'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MissionDto.fromJson(String source) =>
      MissionDto.fromMap(json.decode(source));
}
