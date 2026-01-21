import 'package:nti_project_final/core/network/ApiService.dart';

class ApiOfgetOffers {
  ApiService apiservice = ApiService();

  Future<Map<String, dynamic>> getOffers({int page = 1}) async {
    try {
      final response = await apiservice.getRequest("/offers?page=$page");

      if (response is Map<String, dynamic>) {
        if (response.containsKey('offers')) {
           return response['offers'];
        } else if (response.containsKey('items')) {
           // Maybe the response IS the offers object
           return response;
        }
      }
      
      print("ApiOfgetOffers: Unexpected response structure: $response");
      return {'items': [], 'hasNextPage': false};

    } catch (e) {
      print("ApiOfgetOffers Error: ${e.toString()}");
      return {'items': [], 'hasNextPage': false};
    }
  }
}
