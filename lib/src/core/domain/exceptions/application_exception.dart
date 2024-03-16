class ApplicationException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  ApplicationException(this.message, {this.stackTrace});
}