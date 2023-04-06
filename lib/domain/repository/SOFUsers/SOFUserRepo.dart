import 'package:ovian_test/domain/entities/SOFUsersMain.dart';
import 'package:ovian_test/domain/entities/SOFUsersDetailMain.dart';

abstract class SOFUsersRepo {
  Future<SOFUsersMain?> getSOFUsersList(int page, int pageSize);
  Future<SOFUsersDetailMain?> getSOFUsersDetail(
      int userId, int page, int pageSize);
  Future<List<SOFUser>?> getBookmarkSOFUsersList();
  Future<int?> insertBookmarkUser(SOFUser sofUser);
  Future<void> deleteBookmarkUser(SOFUser sofUser);
}
