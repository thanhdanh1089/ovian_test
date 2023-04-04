import 'package:flutter/material.dart';
import 'package:ovian_test/data/remote/response/ApiResponse.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/repository/SOFUsers/SOFuserRepoImp.dart';

class SOFUsersListVM extends ChangeNotifier {
  final _myRepo = SOFuserRepoImp();

  ApiResponse<SOFUsersMain> sofUserMain = ApiResponse.loading();

  void _setSOFUsersMain(ApiResponse<SOFUsersMain> response) {
    sofUserMain = response;
    notifyListeners();
  }

  Future<void> fetchSOFUsers() async {
    _setSOFUsersMain(ApiResponse.loading());
    _myRepo
        .getSOFUsersList()
        .then((value) => _setSOFUsersMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) => _setSOFUsersMain(ApiResponse.error(error.toString())));
  }
}