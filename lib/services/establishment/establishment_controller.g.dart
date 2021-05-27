// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'establishment_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EstablishmentController on _EstablishmentControllerBase, Store {
  final _$_establishmentsRequestAtom =
      Atom(name: '_EstablishmentControllerBase._establishmentsRequest');

  @override
  ObservableFuture<List<EstablishmentModel>> get _establishmentsRequest {
    _$_establishmentsRequestAtom.reportRead();
    return super._establishmentsRequest;
  }

  @override
  set _establishmentsRequest(ObservableFuture<List<EstablishmentModel>> value) {
    _$_establishmentsRequestAtom
        .reportWrite(value, super._establishmentsRequest, () {
      super._establishmentsRequest = value;
    });
  }

  final _$_EstablishmentControllerBaseActionController =
      ActionController(name: '_EstablishmentControllerBase');

  @override
  void load() {
    final _$actionInfo = _$_EstablishmentControllerBaseActionController
        .startAction(name: '_EstablishmentControllerBase.load');
    try {
      return super.load();
    } finally {
      _$_EstablishmentControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
