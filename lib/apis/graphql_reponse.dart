class GraphQlResponse<T> {
  final T? data;
  final bool isReadableException;
  final dynamic exception;
  final bool isSuccess;
  final int? statusCode;
  final dynamic rawResponse;
  final Map meta;
  String? get publicId => (data as Map?)?['publicId'];
  GraphQlResponse(
      {this.data,
      this.exception,
      this.meta = const {},
      required this.isSuccess,
      this.statusCode,
      this.isReadableException = false,
      this.rawResponse});

  GraphQlResponse.success(
      {this.data,
      this.exception,
      this.meta = const {},
      this.isSuccess = true,
      this.statusCode,
      this.isReadableException = false,
      this.rawResponse});

  GraphQlResponse.failed(
      {this.data,
      this.exception,
      this.meta = const {},
      this.isSuccess = false,
      this.statusCode,
      this.isReadableException = false,
      this.rawResponse});

  bool get isFailed => !isSuccess;

  @override
  String toString() {
    return 'GraphQlResponse(data: $data, isReadableException: $isReadableException, exception: $exception, isSuccess: $isSuccess, statusCode: $statusCode, rawResponse: $rawResponse, meta: $meta)';
  }
}
