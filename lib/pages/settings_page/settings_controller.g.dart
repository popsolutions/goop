// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_SettingsControllerBase.isLoading'))
          .value;
  Computed<bool> _$canNextComputed;

  @override
  bool get canNext => (_$canNextComputed ??= Computed<bool>(() => super.canNext,
          name: '_SettingsControllerBase.canNext'))
      .value;

  final _$emailAtom = Atom(name: '_SettingsControllerBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$phoneAtom = Atom(name: '_SettingsControllerBase.phone');

  @override
  String get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  final _$cpfAtom = Atom(name: '_SettingsControllerBase.cpf');

  @override
  String get cpf {
    _$cpfAtom.reportRead();
    return super.cpf;
  }

  @override
  set cpf(String value) {
    _$cpfAtom.reportWrite(value, super.cpf, () {
      super.cpf = value;
    });
  }

  final _$_updateRequestAtom =
      Atom(name: '_SettingsControllerBase._updateRequest');

  @override
  ObservableFuture<dynamic> get _updateRequest {
    _$_updateRequestAtom.reportRead();
    return super._updateRequest;
  }

  @override
  set _updateRequest(ObservableFuture<dynamic> value) {
    _$_updateRequestAtom.reportWrite(value, super._updateRequest, () {
      super._updateRequest = value;
    });
  }

  final _$_SettingsControllerBaseActionController =
      ActionController(name: '_SettingsControllerBase');

  @override
  void submit() {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase.submit');
    try {
      return super.submit();
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
phone: ${phone},
cpf: ${cpf},
isLoading: ${isLoading},
canNext: ${canNext}
    ''';
  }
}
