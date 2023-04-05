import 'dart:convert';
import 'dart:ffi';
import 'package:ovian_test/data/remote/network/BaseApiService.dart';
import 'package:ovian_test/data/remote/network/NetworkApiService.dart';
import 'package:ovian_test/data/remote/network/ApiEndPoints.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/models/SOFUserDetail/SOFUsersDetailMain.dart';
import 'package:ovian_test/repository/SOFUsers/SOFUserRepo.dart';
import 'package:ovian_test/data/remote/persistentStoregrade/CoreDatabaseStoregrade.dart';

class SOFuserRepoImp implements SOFUsersRepo {
  BaseApiService _apiService = NetworkApiService();
  DatabaseHandler dbHandler = DatabaseHandler();

  @override
  Future<SOFUsersMain?> getSOFUsersList(int page, int pageSize) async {
    try {
      dynamic response = await _apiService
          .getResponse(ApiEndPoints().getSOFListUrl(page, pageSize));
      final jsonData = SOFUsersMain.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SOFUsersDetailMain?> getSOFUsersDetail(
      int userId, int page, int pageSize) async {
    try {
      dynamic response = await _apiService.getResponse(
          ApiEndPoints().getSOFUserDetailUrl(userId, page, pageSize));
      final jsonData = SOFUsersDetailMain.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<SOFUser>?> getBookmarkSOFUsersList() async {
    try {
      return await dbHandler.getAllUsers();
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<int?> insertBookmarkUser(SOFUser sofUser) async {
    try {
      return await dbHandler.insertUser(sofUser);
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> deleteBookmarkUser(SOFUser sofUser) async {
    try {
      return await dbHandler.deleteUser(sofUser.userId!);
    } catch (e) {
      throw e;
    }
  }
}
