// base_api.dart (example)
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:tech_linker_new/models/api-model.dart';
import 'package:tech_linker_new/services/http-service.dart';

class BaseApiService {
  // fromJson: (Map<String, dynamic> json) => Model
Future<ApiResponse<T>> post<T>({
  required String url,
  required Map<String, dynamic> body,
  T Function(Map<String, dynamic>)? fromJson,
}) async {
  final bool hasFile = body.values.any((value) => value is File);

  final httpResp = hasFile
      ? await HttpService.postMultipart(url, body)
      : await HttpService.post(url, body);

  if (!httpResp.success) {
    return ApiResponse<T>(
      success: false,
      message: httpResp.message,
      statusCode: httpResp.statusCode,
      data: null,
    );
  }

  T? data;
  if (httpResp.data != null &&
      httpResp.data is Map<String, dynamic> &&
      fromJson != null) {
    data = fromJson(httpResp.data as Map<String, dynamic>);
  }

  return ApiResponse<T>(
    success: httpResp.success,
    message: httpResp.message,
    statusCode: httpResp.statusCode,
    data: data,
  );
}
Future<ApiResponse<T>> put<T>({
  required String url,
  required Map<String, dynamic> body,
  T Function(Map<String, dynamic>)? fromJson,
}) async {
  final bool hasFile = body.values.any((value) => value is File);

  final httpResp = hasFile
      ? await HttpService.postMultipart(url, body)
      : await HttpService.put(url, body);

  if (!httpResp.success) {
    return ApiResponse<T>(
      success: false,
      message: httpResp.message,
      statusCode: httpResp.statusCode,
      data: null,
    );
  }

  T? data;
  if (httpResp.data != null &&
      httpResp.data is Map<String, dynamic> &&
      fromJson != null) {
    data = fromJson(httpResp.data as Map<String, dynamic>);
  }

  return ApiResponse<T>(
    success: httpResp.success,
    message: httpResp.message,
    statusCode: httpResp.statusCode,
    data: data,
  );
}

Future<ApiResponse<T>> get<T>({
  required String url,
  T Function(Map<String, dynamic>)? fromJson,
}) async {

  final httpResp =
       await HttpService.get(url);

  if (!httpResp.success) {
    return ApiResponse<T>(
      success: false,
      message: httpResp.message,
      statusCode: httpResp.statusCode,
      data: null,
    );
  }

  T? data;
  if (httpResp.data != null &&
      httpResp.data is Map<String, dynamic> &&
      fromJson != null) {
    data = fromJson(httpResp.data as Map<String, dynamic>);
  }

  return ApiResponse<T>(
    success: httpResp.success,
    message: httpResp.message,
    statusCode: httpResp.statusCode,
    data: data,
  );
}


}
