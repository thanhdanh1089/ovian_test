import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';
import 'package:ovian_test/models/SOFUserDetail/SOFUsersDetailMain.dart';

class SOFUsersRepo {
  Future<SOFUsersMain?> getSOFUsersList(int page, int pageSize) async {
    return null;
  }
  Future<SOFUsersDetailMain?> getSOFUsersDetail(
      int userId, int page, int pageSize) async {
        return null;
      }
  Future<List<SOFUser>?> getBookmarkSOFUsersList() async {
    return null;
  }
  Future<int?> insertBookmarkUser(SOFUser sofUser) async {
    return null;
  }
  Future<void> deleteBookmarkUser(SOFUser sofUser) async {}
}
