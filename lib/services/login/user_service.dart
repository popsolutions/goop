import 'package:goop/models/login_dto.dart';
import 'package:goop/models/login_result.dart';
import 'package:goop/models/update_user.dart';
import 'package:goop/models/user.dart';
import 'package:goop/models/user_profile.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

import '../../config/http/odoo_api.dart';
import '../../models/basic_user_dto.dart';
import '../constants.dart';
import 'login_service.dart';

class UserServiceImpl {
  final Odoo _odoo;

  UserServiceImpl(this._odoo);

  Future<UserBasicDto> findById(int id) async {
    final response = await _odoo.searchRead(Strings.resUsers, [
      ["id", "=", id]
    ], []);

    final json = response.getResult()['records'][0];
    return UserBasicDto.fromJson(json);
  }

  Future<UserProfile> findProfile(int partnerId) async {
    final response = await _odoo.searchRead(Strings.resPartner, [
      ["id", "=", partnerId]
    ], [
      'name',
      'phone',
      'image',
      'birthdate',
      'function',
      'cnpj_cpf',
      'education_level',
      'gender',
      // 'missions_count',
      'mobile',
      'email',
      'street',
      'city',
      'district',
      'state',
      'signup_url'
    ]);

    return UserProfile.fromJson(response.getRecords().first);
  }

  Future<void> update(UpdateUser updateProfileDto) async {
    final response = await _odoo.write(
      Strings.resPartner,
      [updateProfileDto.partnerId],
      updateProfileDto.toJson(),
    );
    printL(response);
  }

  Future<User> getUserFromLoginResult(LoginResult loginResult) async {
    final userProfile = await findProfile(loginResult.partnerId,);

    return
      User(
        companyId: loginResult.companyId,
        phone: userProfile.phone,
        isAdmin: loginResult.isAdmin,
        name: loginResult.name,
        partnerDisplayName: loginResult.partnerDisplayName,
        partnerId: loginResult.partnerId,
        sessionId: loginResult.sessionId,
        uid: loginResult.uid,
        userCompanies: loginResult.userCompanies,
        username: loginResult.username,
        birthdate: userProfile.birthdate,
        city: userProfile.city,
        cnpjCpf: userProfile.cnpjCpf,
        district: userProfile.district,
        educationLevel: userProfile.educationLevel,
        email: userProfile.email,
        function: userProfile.function,
        gender: userProfile.gender,
        image: userProfile.imageClass.imageBase64,
        missionsCount: userProfile.missionsCount,
        mobile: userProfile.mobile,
        signupUrl: userProfile.signupUrl,
        state: userProfile.state,
        street: userProfile.street,
      );
  }

  Future<int> createUser(UserProfile userProfile) async {

    LoginServiceImpl login = LoginServiceImpl(Odoo());
    LoginDto loginDto = LoginDto(globalConfig.userOdoo, globalConfig.pass);

    LoginResult currentLoginResult = await login.login(loginDto);

    final response = await _odoo.create(Strings.resUsers, userProfile.toJson());

    if (response.getStatusCode() == 200){
      return response.getResult(); //return id of Measurement_quizzlinesModel
    } else {
      throw 'MeasurementModel quizz lines Insert fail';
    }
  }

  /*

  @override
  Future<ProfileDto> findProfile(int partnerId) async {
    final response = await _odoo.searchRead('res.partner', [
      ["id", "=", partnerId]
    ], [
      'profile_description',
      'music_genre_ids',
      'music_skill_id',
      'function',
      'birthdate_date',
      'gender',
      'city',
      'activity_state',
      'referred_friend_max_distance',
      'partner_current_latitude',
      'partner_current_longitude',
      'interest_male_gender',
      'interest_female_gender',
      "interest_other_genres",
      'referred_friend_min_age',
      'referred_friend_max_age',
      'enable_message_notification',
      'enable_match_notification',
      'referred_friend_ids'
    ]);

    final photosResponse = await _odoo.searchRead('res.partner.image', [
      ['res_partner_id', '=', partnerId]
    ], [
      'id',
      'image'
    ]);
    final images = photosResponse.getRecords();
    final json = response.getResult()['records'][0];
    return ProfileDto.fromJson({...json, 'images': images});
  }

  @override
  Future<void> update(UpdateProfileDto updateProfileDto) async {
    final response = await _odoo.write(
        'res.partner', [updateProfileDto.partnerId], updateProfileDto.toJson());
    print(response);
  }
  */
}
