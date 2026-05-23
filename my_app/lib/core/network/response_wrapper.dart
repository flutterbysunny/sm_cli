class ResponseWrapper<T> {
  final T? data;
  final String? error;
  final int? statusCode;

  ResponseWrapper({
    this.data,
    this.error,
    this.statusCode,
  });

  bool get isSuccess => error == null;
}
