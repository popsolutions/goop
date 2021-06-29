import 'package:goop/utils/utils.dart';

class UserProfile {
  String name;
  // String image;
  ImageGoop imageClass = ImageGoop();
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
  String zip;
  String signupUrl;
  String password;
  String login;

  UserProfile({
    this.name,
    this.phone,
    this.imageClass,
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
    this.zip,
    this.signupUrl,
    this.password,
    this.login
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    name = valueOrNull(json['name']);
    phone = valueOrNull(json['phone']);
    imageClass.imageBase64 = valueOrNull(json['image']);
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
    zip = valueOrNull(json['zip']);
    signupUrl = valueOrNull(json['signup_url']);
    login = valueOrNull(json['login']);
  }

  Map<String, dynamic> toJson() => {
    "login": this.login,
    "name": this.name,
    "image": this.imageClass.imageBase64,
    "phone": this.phone,
    "birthdate": this.birthdate,
    "function": this.function,
    "cnpjCpf": this.cnpjCpf,
    "educationLevel": this.educationLevel,
    "gender": this.gender,
    "missionsCount": this.missionsCount,
    "mobile": this.mobile,
    "email": this.email,
    "street": this.street,
    "city": this.city,
    "district": this.district,
    "state": this.state,
    "zip": this.zip,
    "signupUrl": this.signupUrl,
    "password": this.password
  };

}

