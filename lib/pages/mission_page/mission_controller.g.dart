// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mission_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MissionController on _MissionControllerBase, Store {
  final _$_missionsRequestAtom =
      Atom(name: '_MissionControllerBase._missionsRequest');

  @override
  ObservableFuture<List<MissionModel>> get _missionsRequest {
    _$_missionsRequestAtom.reportRead();
    return super._missionsRequest;
  }

  @override
  set _missionsRequest(ObservableFuture<List<MissionModel>> value) {
    _$_missionsRequestAtom.reportWrite(value, super._missionsRequest, () {
      super._missionsRequest = value;
    });
  }

  final _$_MissionControllerBaseActionController =
      ActionController(name: '_MissionControllerBase');

  @override
  void load() {
    final _$actionInfo = _$_MissionControllerBaseActionController.startAction(
        name: '_MissionControllerBase.load');
    try {
      return super.load();
    } finally {
      _$_MissionControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
