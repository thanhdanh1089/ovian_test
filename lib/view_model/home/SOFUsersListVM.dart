import 'package:flutter/material.dart';
import 'package:ovian_test/data/remote/response/ApiResponse.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/repository/SOFUsers/SOFuserRepoImp.dart';

class SOFUsersListVM extends ChangeNotifier {
  final _myRepo = SOFuserRepoImp();
  List<SOFUser>? users = [];
  List<SOFUser>? bookmarkUsers = [];
  int page = 1;
  int pageSize = 30;
  int nextPage = 2;
  bool isBookmarkFilter = false;

  ApiResponse<SOFUsersMain> sofUserMain = ApiResponse.loading();

  void resetPage() {
    users = [];
    bookmarkUsers = [];
    page = 1;
    nextPage = 2;
  }

  void loadFilterData() {
    isBookmarkFilter = !isBookmarkFilter;
    if (isBookmarkFilter) {
      users = bookmarkUsers;
      notifyListeners();
    } else {
      resetPage();
      fetchSOFUsers();
    }
  }

  void initSOFData() {
    resetPage();
    fetchBookmarkSOFUsers().then((value) {
      fetchSOFUsers();
    });
    
  }
  

  void incrementPage() {
    if (sofUserMain.data?.hasMore == false) return;
    page = nextPage;
    nextPage++;
  }

  void loadingData() {
    for (int i = 0; i < users!.length; i++) {
      for (int j = 0; j < bookmarkUsers!.length; j++) {
        if (users![i].userId == bookmarkUsers![j].userId) {
          users![i].isBookmark = true;
        }
      }
    }
    notifyListeners();
  }

  void loadingDeleteData(SOFUser sofUser) {
    for (int i = 0; i < users!.length; i++) {
      if (users![i].userId == sofUser.userId) {
        users![i].isBookmark = false;
      }
    }
    notifyListeners();
  }

  void _setSOFUsersMain(ApiResponse<SOFUsersMain> response) {
    List<SOFUser>? item = response.data?.sofUsers;
    if (item != null) {
      users!.addAll(item);
    }
    sofUserMain = response;
    loadingData();
  }

  void _setBookmarkSOFUsersMain(List<SOFUser> response) {
    List<SOFUser>? items = response;
    items.forEach((element) { 
      element.isBookmark = true;});
    bookmarkUsers!.addAll(items);
  }

  void _insertBookmarkSOFUsers(int? response) {
    fetchBookmarkSOFUsers();
    notifyListeners();
  }

  void _deleteBookmarkSOFUsers(SOFUser sofUser) {
    loadingDeleteData(sofUser);
    fetchBookmarkSOFUsers();
    notifyListeners();
  }

  SOFUser _setBookmarkSOFUsers(SOFUser sofUser) {
    SOFUser item = sofUser;
    item.isBookmark = true;
    return item;
  }

  Future<void> fetchSOFUsers() async {
    // _setSOFUsersMain(ApiResponse.loading());
    _myRepo
        .getSOFUsersList(page, pageSize)
        .then((value) => _setSOFUsersMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setSOFUsersMain(ApiResponse.error(error.toString())));
  }

  Future<void> fetchBookmarkSOFUsers() async {
    _myRepo
        .getBookmarkSOFUsersList()
        .then((value) => _setBookmarkSOFUsersMain(value!))
        .onError((error, stackTrace) => _setBookmarkSOFUsersMain([]));
  }

  Future<void> insertBookmarkSOFUsers(SOFUser sofUser) async {
    SOFUser updatedSOFUser = _setBookmarkSOFUsers(sofUser);
    _myRepo
        .insertBookmarkUser(updatedSOFUser)
        .then((value) => _insertBookmarkSOFUsers(value!))
        .onError((error, stackTrace) => _insertBookmarkSOFUsers(null));
  }

  Future<void> deleteBookmarkSOFUsers(SOFUser sofUser) async {
    _myRepo
        .deleteBookmarkUser(sofUser)
        .then((value) => _deleteBookmarkSOFUsers(sofUser))
        .onError((error, stackTrace) => _deleteBookmarkSOFUsers(sofUser));
  }
}
