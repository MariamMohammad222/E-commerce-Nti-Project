import 'package:dio/dio.dart';
import 'package:nti_project_final/core/network/ApiExceptions.dart.dart';
import 'package:nti_project_final/core/network/Api_Error.dart';
import 'package:nti_project_final/core/network/dio_consumer.dart';
class ApiService {
  final DioConsumer _dioConsumer = DioConsumer();

  Dio get _dio => _dioConsumer.client;

  Future<dynamic> getRequest(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      print("API Response [$endpoint]: ${response.data}");
      return response.data;
    } catch (e) {
       final String errorStr = e.toString();
       // Safe access to headers/message if it is DioError
       String messageStr = "";
       if (e is DioError) {
          messageStr = e.message ?? "";
       }
       
      if (errorStr.contains("JSON tokens") || 
          messageStr.contains("JSON tokens") ||
          errorStr.contains("is not a subtype of") ||
          messageStr.contains("is not a subtype of") ||
          errorStr.contains("Expected the input to start with a valid JSON token")) {
          
        print("Format/JSON Exception handled for $endpoint (Returning empty {}) - FORCE HANDLED");
        return {};
      }
      
      if (e is DioError) {
        throw ApiXception.handleError(e);
      } else {
        throw e; // Rethrow non-Dio errors
      }
    }
  }

  Future<dynamic> postRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      print("API Response [$endpoint]: ${response.data}");
      return response.data;
    } catch (e) {
      if (e.toString().contains("JSON tokens") || e.toString().contains("is not a subtype of")) {
         return {};
      }
      if (e is DioError) throw ApiXception.handleError(e);
      throw e;
    }
  }

  Future<dynamic> putRequest(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(endpoint, data: data);
      print("API Response [$endpoint]: ${response.data}");
      return response.data;
    } catch (e) {
      if (e.toString().contains("JSON tokens") || e.toString().contains("is not a subtype of")) {
         return {};
      }
      if (e is DioError) throw ApiXception.handleError(e);
      throw e;
    }
  }

  Future<dynamic> deleteRequest(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      print("API Response [$endpoint]: ${response.data}");
      return response.data;
    } catch (e) {
      if (e.toString().contains("JSON tokens") || e.toString().contains("is not a subtype of")) {
         return {};
      }
      if (e is DioError) throw ApiXception.handleError(e);
      throw e;
    }
  }
}

