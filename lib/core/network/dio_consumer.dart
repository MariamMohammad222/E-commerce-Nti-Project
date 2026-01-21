import 'package:dio/dio.dart';
import 'package:nti_project_final/core/utils/app_shared_preferences.dart';

import 'package:dio/dio.dart';


class DioConsumer {
  static final DioConsumer _instance = DioConsumer._internal();
  late Dio client;

  factory DioConsumer() => _instance;

  DioConsumer._internal();

  Future<void> init() async {
    String? token = await AppSharedPreferences.getToken();

    client = Dio(
      BaseOptions(
        baseUrl: "https://accessories-eshop.runasp.net/api",
        // ما نحطش Content-Type هنا، هنضيفه حسب الحاجة
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ),
    );

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Authorization دايمًا
          String? token = await AppSharedPreferences.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          // Content-Type بس لو فيه body (POST/PUT/PATCH)
          if (options.data != null) {
            options.headers["Content-Type"] = "application/json";
          }

          handler.next(options);
        },
      ),
    );
  }
}
