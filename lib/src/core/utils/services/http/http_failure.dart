class HttpFailure implements Exception {
  final String message;
  final int statusCode;
  final StackTrace? stackTrace;
  HttpFailure({
    required this.message,
    this.statusCode = 500,
    this.stackTrace,
  });
}
