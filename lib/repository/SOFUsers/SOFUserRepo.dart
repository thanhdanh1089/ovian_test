import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/models/SOFUserDetail/SOFUsersDetailMain.dart';

class SOFUsersRepo {
  Future<SOFUsersMain?> getSOFUsersList(int page, int pageSize) async {}
  Future<SOFUsersDetailMain?> getSOFUsersDetail(
      int userId, int page, int pageSize) async {}
  Future<List<SOFUser>?> getBookmarkSOFUsersList() async {}
  Future<int?> insertBookmarkUser(SOFUser sofUser) async {}
  Future<void> deleteBookmarkUser(SOFUser sofUser) async {}
}
