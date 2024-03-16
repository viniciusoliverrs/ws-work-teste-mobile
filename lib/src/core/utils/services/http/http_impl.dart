import 'package:dio/dio.dart';

import 'http.dart';
import 'http_failure.dart';
import 'http_response.dart';

class HttpImpl implements IHttp {
  late final Dio clientHttp;
  final String baseUrl;
  final List<Interceptor> interceptors;
  HttpImpl({
    this.interceptors = const [],
    required this.baseUrl,
  }) {
    clientHttp = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 500),
        receiveTimeout: const Duration(milliseconds: 500),
      ),
    );
    clientHttp.interceptors.addAll(interceptors);
  }

  Dio _build({String? baseUrl}) {
    if (baseUrl != null) {
      clientHttp.options.baseUrl = baseUrl;
    }
    clientHttp.options.headers["Accept"] = "application/json";
    clientHttp.options.headers["Content-Type"] = "application/json";
    return clientHttp;
  }

  @override
  Future<HttpResponse<T>> get<T>({
    required String endpoint,
    String? baseUrl,
    int timeout = 25,
    Options? options,
  }) async {
    try {
      final response = await _build(baseUrl: baseUrl).get(endpoint, options: options).timeout(
            Duration(seconds: timeout),
          );
      return HttpResponse<T>(
        data: response.data,
        statusCode: response.statusCode!,
      );
    } on DioException catch (e, s) {
      throw HttpFailure(
        message: e.message ?? "An error occurred",
        stackTrace: s,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  @override
  Future<HttpResponse<T>> post<T>({required String endpoint, required Object body, String? baseUrl}) async {
    try {
      final response = await _build(baseUrl: baseUrl).post(endpoint, data: body);
      return HttpResponse<T>(
        data: response.data,
        statusCode: response.statusCode!,
      );
    } on DioException catch (e, s) {
      throw HttpFailure(
        message: e.message ?? "An error occurred",
        stackTrace: s,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
