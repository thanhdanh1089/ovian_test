import 'package:flutter/material.dart';
import 'package:ovian_test/data/remote/response/ApiResponse.dart';
import 'package:ovian_test/domain/entities/SOFUsersDetailMain.dart';
import 'package:ovian_test/domain/repository/SOFUsers/SOFuserRepoImp.dart';

class SOFUserDetailVM extends ChangeNotifier {
  final _myRepo = SOFuserRepoImp();
  List<SOFPost>? posts = [];
  int? userId;
  int page = 1;
  int pageSize = 30;
  int nextPage = 2;

  ApiResponse<SOFUsersDetailMain> sofUserDetailMain = ApiResponse.loading();

  void resetPage() {
    posts = [];
    page = 1;
    nextPage = 2;
  }

  void initSOFData() {
    resetPage();
    fetchSOFUserDetail();
  }

  void incrementPage() {
    if (sofUserDetailMain.data?.hasMore == false) return;
    page = nextPage;
    nextPage++;
  }

  void _setSOFUsersDetailMain(ApiResponse<SOFUsersDetailMain> response) {
    List<SOFPost>? item = response.data?.sofPost;
    if (item != null) {
      posts!.addAll(item);
    }
    sofUserDetailMain = response;
    notifyListeners();
  }

  Future<void> fetchSOFUserDetail() async {
    if (userId == null) return;
    _myRepo
        .getSOFUsersDetail(userId!, page, pageSize)
        .then((value) => _setSOFUsersDetailMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setSOFUsersDetailMain(ApiResponse.error(error.toString())));
  }
}
