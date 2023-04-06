class ApiEndPoints {
  final String getSOFList = "users";

  String getSOFListUrl(int page, int pageSize) {
    return "$getSOFList?page=$page&pagesize=$pageSize&site=stackoverflow";
  }
  
  String getSOFUserDetailUrl(int userId, int page, int pageSize) {
    return "users/$userId/reputation-history?page=$page&pagesize=$pageSize&site=stackoverflow";
  }
}
