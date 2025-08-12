// api_response.dart
class ApiResponse<T> {
  final bool success;
  final String message;
  final int statusCode;
  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    this.data,
  });

  /// Creates an ApiResponse<T> from a decoded JSON map.
  ///
  /// - [json] is the decoded response body (Map<String, dynamic>).
  /// - [fromJson] is an optional converter that converts a Map<String, dynamic>
  ///   (usually the `data` field) into T. Provide it for complex models.
  /// - [statusCode] is optional and defaults to 200 if not supplied.
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? fromJson,
    int statusCode = 200,
  }) {
    final bool success = json['success'] == true;
    final String message = json['message']?.toString() ?? '';
    final dynamic rawData = json['data'];

    T? parsedData;
    if (rawData != null) {
      try {
        // If the caller gave a fromJson and rawData is a Map, use it.
        if (fromJson != null && rawData is Map<String, dynamic>) {
          parsedData = fromJson(rawData);
        } else {
          // Otherwise attempt a direct cast (works for primitives or already-correct types).
          parsedData = rawData as T?;
        }
      } catch (e) {
        // Parsing failed — leave parsedData as null (caller can handle this).
        parsedData = null;
      }
    }

    return ApiResponse<T>(
      success: success,
      message: message,
      statusCode: statusCode,
      data: parsedData,
    );
  }
}
