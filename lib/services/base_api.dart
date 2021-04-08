import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/loggin_interceptor.dart';

Client client = HttpClientWithInterceptor.build(
    requestTimeout: Duration(seconds: 5),
    interceptors: [
      LoggingInterceptor(),
    ]);

const String baseUrl = 'http://192.168.0.108:8080';
