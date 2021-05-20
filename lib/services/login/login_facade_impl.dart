import '../../models/login_dto.dart';
import '../../models/user.dart';
import './login_service.dart';
import './user_service.dart';

class LoginFacade {
  final LoginServiceImpl _loginService;
  final UserServiceImpl _userService;

  LoginFacade(this._loginService, this._userService);

  Future<User> login(LoginDto loginDto) async {
    final loginResponse = await _loginService.login(loginDto);
    final userProfile = await _userService.findProfile(
      loginResponse.partnerId,
    );
    return User(
      companyId: loginResponse.companyId,
      phone: userProfile.phone,
      isAdmin: loginResponse.isAdmin,
      name: loginResponse.name,
      partnerDisplayName: loginResponse.partnerDisplayName,
      partnerId: loginResponse.partnerId,
      sessionId: loginResponse.sessionId,
      uid: loginResponse.uid,
      userCompanies: loginResponse.userCompanies,
      username: loginResponse.username,
      birthdate: userProfile.birthdate,
      city: userProfile.city,
      cnpjCpf: userProfile.cnpjCpf,
      district: userProfile.district,
      educationLevel: userProfile.educationLevel,
      email: userProfile.email,
      function: userProfile.function,
      gender: userProfile.gender,
      image: userProfile.image,
      missionsCount: userProfile.missionsCount,
      mobile: userProfile.mobile,
      signupUrl: userProfile.signupUrl,
      state: userProfile.state,
      street: userProfile.street,
    );
  }
}
