import 'package:ovian_test/viewModel/home/SOFUsersListVM.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:ovian_test/repository/SOFUsers/SOFuserRepoImp.dart';
import 'package:ovian_test/models/SOFUserList/SOFUsersMain.dart';

@GenerateMocks([http.Client])
void main() {
  group('vm static input', () {
    test('vm resetPage function', () {
      SOFUsersListVM viewmodel = SOFUsersListVM();
      for (int i = 0; i < 10; i++) {
        viewmodel.incrementPage();
      }
      viewmodel.resetPage();
      expect(viewmodel.nextPage, 2);
      expect(viewmodel.page, 1);
      expect(viewmodel.users, []);
    });

    test('vm incrementPage function', () {
      SOFUsersListVM viewmodel = SOFUsersListVM();
      for (int i = 0; i < 10; i++) {
        viewmodel.incrementPage();
        expect(viewmodel.nextPage, viewmodel.page + 1);
      }
      expect(viewmodel.page, 11);
      expect(viewmodel.nextPage, 12);
    });

    test('vm update bookmark user function', () {
      SOFUser sofUser = SOFUser.fromJson({
        "user_id": 22656,
        "display_name": "Jon Skeet",
        "reputation": 1,
        "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
        "isBookmark": false
      });
      SOFUser updateSOFUser = SOFUsersListVM().setBookmarkSOFUsers(sofUser);
      expect(updateSOFUser.isBookmark, true);
    });

    test('vm loadingData function', () {
      List<SOFUser>? users = [
        SOFUser.fromJson({
          "user_id": 1,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": false
        }),
        SOFUser.fromJson({
          "user_id": 2,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": false
        }),
        SOFUser.fromJson({
          "user_id": 3,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": false
        }),
      ];
      List<SOFUser>? bookmarkUsers = [
        SOFUser.fromJson({
          "user_id": 1,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": true
        })
      ];
      SOFUsersListVM viewmodel = SOFUsersListVM();
      viewmodel.users = users;
      viewmodel.bookmarkUsers = bookmarkUsers;
      viewmodel.loadingData();
      expect(viewmodel.users!.first.isBookmark, true);
    });
    test('vm loadingDeleteData function', () {
      List<SOFUser>? users = [
        SOFUser.fromJson({
          "user_id": 1,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": false
        }),
        SOFUser.fromJson({
          "user_id": 2,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": true
        }),
        SOFUser.fromJson({
          "user_id": 3,
          "display_name": "Jon Skeet",
          "reputation": 1,
          "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
          "isBookmark": false
        }),
      ];
      SOFUser sofUserUnBookmark = SOFUser.fromJson({
        "user_id": 2,
        "display_name": "Jon Skeet",
        "reputation": 1,
        "profile_image": "https://i.stack.imgur.com/0Hq5x.jpg?s=128&g=1",
        "isBookmark": false
      });
      SOFUsersListVM viewmodel = SOFUsersListVM();
      viewmodel.users = users;
      viewmodel.loadingDeleteData(sofUserUnBookmark);
      expect(viewmodel.users![1].isBookmark, false);
    });
  });

  group('vm fetch data from api', () {
    test('getSOFUsersList test first request', () async {
      final myRepo = SOFuserRepoImp();
      final apiResponse = await myRepo.getSOFUsersList(1, 30);
      expect(apiResponse!, isA<SOFUsersMain>());
      expect(apiResponse.sofUsers!.first, isA<SOFUser>());
      expect(apiResponse.hasMore, true);
    });

    test('getSOFUsersList test page 25 request', () async {
      final myRepo = SOFuserRepoImp();
      final apiResponse = await myRepo.getSOFUsersList(25, 30);
      expect(apiResponse!, isA<SOFUsersMain>());
      expect(apiResponse.sofUsers!.first, isA<SOFUser>());
      expect(apiResponse.hasMore, true);
    });
  });
}
