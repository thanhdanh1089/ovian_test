class ApiEndPoints {
  final String getSOFList = "users";
  // ?page=1&pagesize=30&site=stackoverflow
  String getSOFListUrl(int page, int pageSize) {
    return getSOFList +
        "?page=" +
        page.toString() +
        "&pagesize=" +
        pageSize.toString() +
        "&site=stackoverflow";
  }

//   https://api.stackexchange.com/2.2/users/{userId}/reputation-history?
// page=1&pagesize=30&site=stackoverflow
  String getSOFUserDetailUrl(int userId, int page, int pageSize) {
    return "users/" +
        userId.toString() +
        "/reputation-history" +
        "?page=" +
        page.toString() +
        "&pagesize=" +
        pageSize.toString() +
        "&site=stackoverflow";
  }
}
