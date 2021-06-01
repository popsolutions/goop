import 'package:goop/models/establishment.dart';
import 'package:goop/services/establishment/establishment_service.dart';
import 'package:mobx/mobx.dart';
part 'establishment_controller.g.dart';

class EstablishmentController = _EstablishmentControllerBase
    with _$EstablishmentController;

abstract class _EstablishmentControllerBase with Store {
  final EstablishmentService _establishmentService;

  _EstablishmentControllerBase(this._establishmentService);

  @observable
  ObservableFuture<List<EstablishmentModel>> _establishmentsRequest =
      ObservableFuture.value(null);

  ObservableFuture<List<EstablishmentModel>> get establishmentsRequest =>
      _establishmentsRequest;

  @action
  void load() {
    _establishmentsRequest =
        _establishmentService.getMissionEstablishments().asObservable();
  }
}
