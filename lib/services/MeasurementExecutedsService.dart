import 'package:goop/models/dtos/MeasurementExecutedsDto.dart';
import 'package:goop/services/absService.dart';
import 'package:goop/services/constants.dart';
import 'package:goop/utils/global.dart';
import 'package:goop/utils/utils.dart';

class MeasurementExecutedsService extends absService{
  Future<List<MeasurementExecutedsDto>> getMeasurementExecutedsDto() async {
    final response = await odoo.searchRead(
      Strings.meassurement,
      [
        ["state", "in", ["done", "approved", "rejected"]],
        ["partner_id", "in", [globalcurrentUser.partnerId]]
      ],
      ["id", "missions_id", "partner_id", "state"],
    );

    final List json = response.getRecords();
    final listMeasurementExecutedsDto = json.map((e) => MeasurementExecutedsDto.fromJson(e)).toList();


    List<int> listIds = [];

    listMeasurementExecutedsDto.forEach((element) {
      listIds.add(element.missions_id);
    });


    final responseMissions = await odoo.searchRead(
      Strings.missions,
      [
        ["id", "in", listIds]
      ],
      ["name", "reward"],
    );

    final List jsonMissions = responseMissions.getRecords();

    for (var elementjsonMissions in jsonMissions) {
      for (var elementlistMeasurementExecutedsDto in listMeasurementExecutedsDto) {
        if (elementlistMeasurementExecutedsDto.missions_id == elementjsonMissions['id']) {
          elementlistMeasurementExecutedsDto.reward = JsonGet.Double(elementjsonMissions, 'reward');
          elementlistMeasurementExecutedsDto.name = JsonGet.Str(elementjsonMissions, 'name');
        }
      }
    }

    return listMeasurementExecutedsDto;
  }
}