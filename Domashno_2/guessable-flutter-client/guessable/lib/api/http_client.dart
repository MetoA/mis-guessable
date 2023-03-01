import 'package:http_interceptor/http/intercepted_client.dart';

import 'api_interceptor.dart';

class HttpClient {
  static final client = InterceptedClient.build(interceptors: [ApiInterceptor()]);
}
