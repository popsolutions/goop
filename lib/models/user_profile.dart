import 'package:goop/utils/utils.dart';

class UserProfile {
  String name;
  String image;
  String phone;
  String birthdate;
  String function;
  String cnpjCpf;
  String educationLevel;
  String gender;
  int missionsCount;
  String mobile;
  String email;
  String street;
  String city;
  String district;
  String state;
  String signupUrl;

  UserProfile({
    this.name,
    this.phone,
    this.image,
    this.birthdate,
    this.function,
    this.cnpjCpf,
    this.educationLevel,
    this.gender,
    this.missionsCount,
    this.mobile,
    this.email,
    this.street,
    this.city,
    this.district,
    this.state,
    this.signupUrl,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = valueOrNull(json['name']);
    phone = valueOrNull(json['phone']);
    image = valueOrNull(json['image']);
    birthdate = valueOrNull(json['birthdate']);
    function = valueOrNull(json['function']);
    cnpjCpf = valueOrNull(json['cnpj_cpf']);
    educationLevel = valueOrNull(json['education_level']);
    gender = valueOrNull(json['gender']);
    missionsCount = valueOrNull(json['missions_count']);
    mobile = valueOrNull(json['mobile']);
    email = valueOrNull(json['email']);
    street = valueOrNull(json['street']);
    city = valueOrNull(json['city']);
    district = valueOrNull(json['district']);
    state = valueOrNull(json['state']);
    signupUrl = valueOrNull(json['signup_url']);
  }
}
