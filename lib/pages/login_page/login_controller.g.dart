// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool>? _$canNextComputed;

  @override
  bool get canNext => (_$canNextComputed ??= Computed<bool>(() => super.canNext,
          name: '_LoginControllerBase.canNext'))
      .value;
  Computed<bool>? _$isLoadingComputed;

  @override
  bool get isLoading =>
      (_$isLoadingComputed ??= Computed<bool>(() => super.isLoading,
              name: '_LoginControllerBase.isLoading'))
          .value;

  final _$loginRequestAtom = Atom(name: '_LoginControllerBase.loginRequest');

  @override
  ObservableFuture<User> get loginRequest {
    _$loginRequestAtom.reportRead();
    return super.loginRequest;
  }

  @override
  set loginRequest(ObservableFuture<User> value) {
    _$loginRequestAtom.reportWrite(value, super.loginRequest, () {
      super.loginRequest = value;
    });
  }

  final _$loginAtom = Atom(name: '_LoginControllerBase.login');

  @override
  String get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(String value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginControllerBase.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  void submit() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.submit');
    try {
      return super.submit();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginRequest: ${loginRequest},
login: ${login},
password: ${password},
canNext: ${canNext},
isLoading: ${isLoading}
    ''';
  }
}
