import 'package:goop/models/absModels.dart';

class User extends AbsModels {
  final String sessionId;
  final String password;
  final int uid;
  final bool isAdmin;
  final String name;
  final String username;
  final String partnerDisplayName;
  final int companyId;
  final int partnerId;
  final bool userCompanies;
  String image;
  final String birthdate;
  final String function;
  final String cnpjCpf;
  final String educationLevel;
  final String gender;
  final int missionsCount;
  final String mobile;
  final String phone;
  final String email;
  final String street;
  final String city;
  final String district;
  final String state;
  final String signupUrl;

  User({
    this.sessionId,
    this.password,
    this.uid,
    this.isAdmin,
    this.name,
    this.phone,
    this.username,
    this.partnerDisplayName,
    this.companyId,
    this.partnerId,
    this.userCompanies,
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

  User copyWith({
    final String sessionId,
    final int uid,
    final bool isAdmin,
    final String name,
    final String username,
    final String partnerDisplayName,
    final int companyId,
    final int partnerId,
    final bool userCompanies,
    final String image,
    final String birthdate,
    final String function,
    final String cnpjCpf,
    final String educationLevel,
    final String gender,
    final String missionsCount,
    final String mobile,
    final String email,
    final String street,
    final String city,
    final String district,
    final String state,
    final String signupUrl,
  }) {
    return User(
      name: name ?? this.name,
    );
  }
}
