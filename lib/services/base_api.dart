import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/loggin_interceptor.dart';

Client client = HttpClientWithInterceptor.build(
    requestTimeout: Duration(seconds: 5),
    interceptors: [
      LoggingInterceptor(),
    ]);
