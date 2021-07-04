import 'package:goop/models/absModels.dart';
import 'package:goop/utils/utils.dart';

class UserProfile extends AbsModels {
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
    currentJson = json;

    name = jGetStr('name');
    phone = jGetStr('phone');
    imageClass.imageBase64 = jGetStr('image');
    birthdate = jGetStr('birthdate');
    function = jGetStr('function');
    cnpjCpf = jGetStr('cnpj_cpf');
    educationLevel = jGetStr('education_level');
    gender = jGetStr('gender');
    missionsCount = jGetInt('missions_count');
    mobile = jGetStr('mobile');
    email = jGetStr('email');
    street = jGetStr('street');
    city = jGetStr('city');
    district = jGetStr('district');
    state = jGetStr('state');
    zip = jGetStr('zip');
    signupUrl = jGetStr('signup_url');
    login = jGetStr('login');
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

