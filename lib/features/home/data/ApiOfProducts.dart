import 'package:dio/dio.dart';
import 'package:nti_project_final/core/network/ApiExceptions.dart.dart';
import 'package:nti_project_final/core/network/ApiService.dart';
import 'package:nti_project_final/core/network/Api_Error.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';

class Apiofproducts {
  ApiService apiservice = ApiService();

  Future<List<Modelofproducts>> getProducts({
    String? categoryId,   
    int page = 1,
    int pageSize = 6,
  }) async {
    try {
      String url = "/products?page=$page&pageSize=$pageSize";

      if (categoryId != null) {
        url += "&categoryId=$categoryId";  // ضيف الفلتر على حسب الفئة
      }
         
      final response = await apiservice.getRequest(url);

      final List items = response['items'];
      return items.map((e) => Modelofproducts.fromJson(e)).toList();
    } catch (e) {
      print(e);
      return [];
    }
  }
}

