import 'package:goop/models/absModels.dart';

class MeasurementExecutedsDto extends AbsModels{
  int id;
  String name;
  String state;
  int missions_id;
  double missions_reward;
  int partner_id;
  double reward;

  get stateText{
    if (state == 'done') return 'Concluída';
    if (state == 'approved') return 'Aprovada';
    if (state == 'rejected') return 'Rejeitada';
    return '';
  }

  MeasurementExecutedsDto.fromJson(Map<String, dynamic> json) {
    currentJson = json;

    id = jGetInt('id');
    state = jGetStr('state');
    missions_id = jGetInt( 'missions_id', 0);
    partner_id = jGetInt('partner_id', 0);
  }
}