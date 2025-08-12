class ApiResponseBase<T> {
  bool success;
  T? data;
  String? message;
  ApiResponseBase({required this.success, this.data, this.message});
}