import 'package:nti_project_final/core/network/ApiService.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';

class Getproductsbycategory {
  ApiService apiservice = ApiService();

Future<List<Modelofproducts>> getProductsByCategory(String categoryName) async {
  try {
    final Map<String, dynamic> response =
        await apiservice.getRequest("/products/categories/$categoryName");

    final List items = response['items'] ?? [];

    return items
        .map((e) => Modelofproducts.fromJson(e))
        .toList();
  } catch (e) {
    print("API ERROR: $e");
    return [];
  }
}

}


