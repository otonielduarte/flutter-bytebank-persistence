import 'dart:developer';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    log('$data');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    log('$data');
    return data;
  }
}
