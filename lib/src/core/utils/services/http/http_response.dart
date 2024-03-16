class HttpResponse<T> {
  final T data;
  final int statusCode;
  HttpResponse({
    required this.data,
    this.statusCode = 500,
  });
}
