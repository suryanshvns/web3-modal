import 'package:graphql_flutter/graphql_flutter.dart';

class ApiResponse {
  final Map<String, dynamic>? headers;
  final dynamic data;
  final dynamic exception;
  final bool isSuccess;
  final int? statusCode;
  final dynamic rawResponse;
  bool get isFailed => !isSuccess;
  ApiResponse(
      {this.headers,
      this.data,
      required this.isSuccess,
      this.statusCode,
      this.exception,
      this.rawResponse});

  factory ApiResponse.failed([Map? except]) =>
      ApiResponse(isSuccess: false, exception: except);
  factory ApiResponse.success([dynamic data]) =>
      ApiResponse(isSuccess: true, data: data);

  factory ApiResponse.fromQuerySaveDataResult(QueryResult result,
      [bool ensurePublicId = false]) {
    String? accessKey;
    try {
      accessKey =
          (result.data?.keys.firstWhere((element) => element != '__typename'));
    } catch (e) {
      print(e);
    }

    bool isSuccess = (!result.hasException &&
        result.data != null &&
        result.data![accessKey]?['data']?['publicId'] != null);

    return ApiResponse(
        isSuccess:
            isSuccess ? isSuccess : !(ensurePublicId && result.hasException),
        data: result.data![accessKey]['data']);
  }
  @override
  String toString() {
    return 'ApiResponse(headers: $headers, data: $data, isSuccess: $isSuccess, statusCode: $statusCode), exception: ${exception.toString()}';
  }
}
