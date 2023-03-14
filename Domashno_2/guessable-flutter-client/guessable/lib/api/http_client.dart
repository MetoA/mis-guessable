import 'package:http_interceptor/http/intercepted_client.dart';

import 'api_interceptor.dart';

/// An http client used for communication with the API, built with an [ApiInterceptor]
class HttpClient {
  static final client = InterceptedClient.build(interceptors: [ApiInterceptor()]);
}
