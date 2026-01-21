import 'package:nti_project_final/core/network/ApiService.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfCategory.dart';

class Apiofcategory {
      ApiService apiservice = ApiService();

  Future<List<Modelofcategory>> getCategories() async {
    try {
      // استقبلي الريسبونس كله كـ Map
      final Map<String, dynamic> response =
          await apiservice.getRequest("/categories/");

      // خدي items بس
      final List items = response['categories'];

      return items
          .map((e) => Modelofcategory.fromJson(e))
          .toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}