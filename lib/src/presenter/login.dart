import 'dart:convert';

import 'package:TPMDriver/helper/paths.dart';
import 'package:TPMDriver/helper/rijndael.dart';
import 'package:TPMDriver/src/model/login.dart';
import 'package:TPMDriver/src/model/user.dart';
import 'package:TPMDriver/src/resources/session.dart';
import 'package:TPMDriver/src/resources/userApi.dart';
import 'package:TPMDriver/src/state/login.dart';
import 'package:TPMDriver/helper/getStorage.dart' as constants;
import 'package:get_storage/get_storage.dart';

abstract class LoginPresenterAbstract {
  set view(LoginState view) {}
  void loginClicked() {}
}

class LoginPresenter implements LoginPresenterAbstract {
  LoginModel _loginModel = new LoginModel();
  LoginState _loginState;
  UserApi _userApi = new UserApi();

  @override
  void loginClicked() {
    // ignore: todo
    // TODO: implement loginClicked
    // ignore: unused_local_variable
    String username, password;
    username = _loginModel.username.text;
    password = _loginModel.password.text;
    this._loginModel.isloading = true;
    this._loginState.refreshData(this._loginModel);
    Map param = {'username': '$username', 'password': '$password'};
    _userApi.login(username, password).then((res) async {
      Session.setId(int.parse(res.data.idUser));
      Session.setName(res.data.username);

      Session.setPicture("");

      await GetStorage().write(constants.ID_MURID, res.data.idUser);
      await GetStorage().write(constants.NAMA_USER, res.data.username);
      this._loginModel.isloading = false;
      this._loginState.refreshData(this._loginModel);
      this._loginState.onSuccess("yeh, Berhasil");
    }).catchError((onError) {
      this._loginModel.isloading = false;
      this._loginState.refreshData(this._loginModel);
      this._loginState.onError("password atau username salah");
    });
  }

  @override
  // ignore: avoid_return_types_on_setters
  void set view(LoginState view) {
    // ignore: todo
    // TODO: implement view
    this._loginState = view;
    this._loginState.refreshData(this._loginModel);
  }
}
