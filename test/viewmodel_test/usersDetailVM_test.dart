import 'package:ovian_test/viewModel/detail/SOFUserDetailVM.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:ovian_test/repository/SOFUsers/SOFuserRepoImp.dart';
import 'package:ovian_test/models/SOFUserDetail/SOFUsersDetailMain.dart';

@GenerateMocks([http.Client])
void main() {
  group('vm static input', () {
    test('vm resetPage function', () {
      SOFUserDetailVM viewmodel = SOFUserDetailVM();
      for (int i = 0; i < 20; i++) {
        viewmodel.incrementPage();
      }
      viewmodel.resetPage();
      expect(viewmodel.nextPage, 2);
      expect(viewmodel.page, 1);
      expect(viewmodel.posts, []);
    });

    test('vm incrementPage function', () {
      SOFUserDetailVM viewmodel = SOFUserDetailVM();
      for (int i = 0; i < 50; i++) {
        viewmodel.incrementPage();
      }
      expect(viewmodel.page, 51);
      expect(viewmodel.nextPage, 52);
    });
  });

  group('vm fetch data from api', () {
    test('getSOFUsersDetail test first request', () async {
      final myRepo = SOFuserRepoImp();
      final apiResponse = await myRepo.getSOFUsersDetail(9473764, 1, 30);
      expect(apiResponse!, isA<SOFUsersDetailMain>());
      expect(apiResponse.sofPost!.first, isA<SOFPost>());
      expect(apiResponse.hasMore, true);
    });

    test('getSOFUsersList test page 25 request', () async {
      final myRepo = SOFuserRepoImp();
      final apiResponse = await myRepo.getSOFUsersDetail(9473764, 25, 30);
      expect(apiResponse!, isA<SOFUsersDetailMain>());
      expect(apiResponse.sofPost!.first, isA<SOFPost>());
      expect(apiResponse.hasMore, true);
    });
  });
}
