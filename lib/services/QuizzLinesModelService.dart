
import 'package:goop/config/http/odoo_api.dart';
import 'package:goop/models/quizzLinesModel.dart';
import 'package:goop/services/constants.dart';

class QuizzLinesModelService {
  Odoo _odoo = new Odoo();

  Future<List<QuizzLinesModel>> getQuizzLinesModelFromQuizz(int quizz_id) async {
    final response = await _odoo.searchRead(
      Strings.popsQuizzLines,
      [
        ['quizz_id', 'in', [quizz_id]]
      ],
      [],
    );
    final List json = response.getRecords();
    final listMission = json.map((e) => QuizzLinesModel.fromJson(e)).toList();
    return listMission;
  }

}