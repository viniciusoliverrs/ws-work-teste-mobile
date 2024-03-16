import 'http_response.dart';

abstract class IHttp {
  Future<HttpResponse<T>> get<T>({
    required String endpoint,
    String? baseUrl,
  });

  Future<HttpResponse<T>> post<T>({
    required String endpoint,
    required Object body,
    String? baseUrl,
  });
}
