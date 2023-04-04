import 'dart:convert';
import 'package:ovian_test/data/remote/network/BaseApiService.dart';
import 'package:ovian_test/data/remote/network/NetworkApiService.dart';
import 'package:ovian_test/data/remote/network/ApiEndPoints.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/repository/SOFUsers/SOFUserRepo.dart';


class SOFuserRepoImp implements SOFUsersRepo{

  BaseApiService _apiService = NetworkApiService();

  @override
  Future<SOFUsersMain?> getSOFUsersList() async {
    try {
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().getSOFList);
      final jsonData = SOFUsersMain.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

}