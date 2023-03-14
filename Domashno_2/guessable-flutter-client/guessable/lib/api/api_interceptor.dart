import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An HTTP interceptor that activates for every HTTP request and does some logic
///
/// This interceptor sets 'Content-Type' and 'Accept' headers, and if the user is logged in a 'Authorization' header with the JWT token
class ApiInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    String? authToken = sharedPreferences.getString('auth_token');
    data.headers['Content-type'] = 'application/json';
    data.headers['Accept'] = 'application/json';

    if (authToken != null) {
      data.headers['Authorization'] = authToken;
    }

    return data;
  }

  @override
  interceptResponse({required ResponseData data}) async => data;
}
