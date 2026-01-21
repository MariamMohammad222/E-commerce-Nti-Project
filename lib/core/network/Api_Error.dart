class ApiError{
  final int? code;
  final String? message;

  ApiError({this.code, this.message});
  String toString() => 'ApiError(code: $code, message: $message)';
}