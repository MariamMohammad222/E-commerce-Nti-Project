import 'package:dio/dio.dart';
import 'package:nti_project_final/core/network/Api_Error.dart';

class ApiXception {
  static ApiError handleError(DioError error) {
    // أول حاجة نتأكد من وجود response
    if (error.response != null && error.response!.data != null) {
      final data = error.response!.data;

      if (data is Map<String, dynamic>) {
        // لو فيه errors
        if (data['errors'] != null && data['errors'] is Map) {
          final errors = data['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final firstError = errors.values.first;

            if (firstError is List && firstError.isNotEmpty) {
              // لو Array of messages
              return ApiError(message: firstError.first.toString());
            } else if (firstError is String) {
              // لو String
              return ApiError(message: firstError);
            }
          }
        }

        // لو فيه message مباشرة
        if (data['message'] != null) {
          return ApiError(message: data['message'].toString());
        }
      }
    }

    // باقي أنواع الأخطاء
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(message: 'Connect Timeout');
      case DioExceptionType.receiveTimeout:
        return ApiError(message: 'Receive Timeout');
      case DioExceptionType.sendTimeout:
        return ApiError(message: 'Send Timeout');
      case DioExceptionType.badCertificate:
        return ApiError(message: 'Bad Certificate');
      case DioExceptionType.badResponse:
        return ApiError(message: 'Bad Response');
      case DioExceptionType.cancel:
        return ApiError(message: 'Canceled');
      case DioExceptionType.connectionError:
        return ApiError(message: 'Connection Error');
      case DioExceptionType.unknown:
      default:
        return ApiError(message: 'Unknown Error');
    }
  }
}