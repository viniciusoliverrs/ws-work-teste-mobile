class MapperException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  MapperException(
    this.message, {
    this.stackTrace,
  });
}
