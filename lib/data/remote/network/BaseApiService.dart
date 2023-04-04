abstract class BaseApiService {

  final String baseUrl = "https://api.stackexchange.com/2.2/";

  Future<dynamic> getResponse(String url);

}