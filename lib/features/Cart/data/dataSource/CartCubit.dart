import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/core/network/ApiService.dart';
import 'package:nti_project_final/features/Cart/data/dataSource/apiModels.dart';

import 'package:nti_project_final/features/Cart/presentation/screens/models/CartModel.dart';

class CartCubit extends Cubit<List<CartItem>> {
  final ApiService _apiService = ApiService();

  CartCubit() : super([]);

  Future<void> fetchCart() async {
    try {
      final json = await _apiService.getRequest('/cart');
      final cartResponse = CartResponse.fromJson(json);

      final items = cartResponse.cartItems
          .map((apiItem) => _mapApiToModel(apiItem))
          .toList();

      emit(items);
    } catch (e) {
      emit([]);
    }
  }

  CartItem _mapApiToModel(CartItemApi apiItem) {
    return CartItem(
      id: apiItem.itemId,
      title: apiItem.productName,
      price: apiItem.finalPricePerUnit,
      imageUrl: apiItem.productCoverUrl,
      quantity: apiItem.quantity,
      mrpPrice: apiItem.basePricePerUnit,
    );
  }

  Future<void> addItem(String productId) async {
    try {
      await _apiService.postRequest(
        '/cart/items',
        {
          "productId": productId,
          "quantity": 1,
        },
      );
      await fetchCart();
    } catch (e) {}
  }

  Future<void> incrementQuantity(String itemId, int currentQty) async {
    try {
      await _apiService.putRequest(
        '/cart/items/$itemId',
        {"quantity": currentQty + 1},
      );
      await fetchCart();
    } catch (e) {}
  }

  Future<void> decrementQuantity(String itemId, int currentQty) async {
    if (currentQty <= 1) return;

    try {
      await _apiService.putRequest(
        '/cart/items/$itemId',
        {"quantity": currentQty - 1},
      );
      await fetchCart();
    } catch (e) {}
  }

  Future<void> removeItem(String itemId) async {
    try {
      await _apiService.deleteRequest('/cart/items/$itemId');
      await fetchCart();
    } catch (e) {}
  }

  double get subtotal =>
      state.fold(0, (sum, item) => sum + item.price * item.quantity);
}
