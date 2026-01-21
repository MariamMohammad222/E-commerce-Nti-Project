import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/features/home/data/ApiOfProducts.dart';
import 'package:nti_project_final/features/home/data/ApiOfcategories.dart';
import 'package:nti_project_final/features/home/data/ApiOfgetOffers.dart';
import 'package:nti_project_final/features/home/data/getProductsByCategory.dart';
import 'package:nti_project_final/features/home/presentation/cubit/HomeState.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfCategory.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/modelsOfoffers.dart';

class HomeCubit extends Cubit<HomeState> {
  final Apiofproducts _productsApi = Apiofproducts();
  final Apiofcategory _categoriesApi = Apiofcategory();
  final ApiOfgetOffers _offersApi = ApiOfgetOffers();
  final Getproductsbycategory _categoryProductsApi = Getproductsbycategory();

  List<Modelofproducts> _allProducts = [];
  List<Modelofproducts> _displayedProducts = [];
  List<Modelofcategory> _categories = [];
  List<OfferModel> _offers = [];
  
  int _productsPage = 1;
  bool _hasMoreProducts = true;
  bool _isLoadingMore = false;
  String? _currentCategoryId;
  static const int pageSize = 20;

  HomeCubit() : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      // Create futures to run in parallel
      final productsFuture = _productsApi.getProducts(page: 1);
      final categoriesFuture = _categoriesApi.getCategories();
      final offersFuture = _offersApi.getOffers(page: 1);

      final results = await Future.wait([productsFuture, categoriesFuture, offersFuture]);

      _allProducts = results[0] as List<Modelofproducts>;
      _categories = results[1] as List<Modelofcategory>;
      
      // Offers parsing (API returns map with items)
      final offersData = results[2] as Map<String, dynamic>;
      final List offersItems = offersData['items'] ?? [];
      _offers = offersItems.map((e) => OfferModel.fromJson(e)).toList();

      _displayedProducts = List.from(_allProducts);
      _productsPage = 2; // Next page

      emit(HomeSuccess(
        products: _displayedProducts,
        categories: _categories,
        offers: _offers,
        hasMoreProducts: _allProducts.isNotEmpty,
      ));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore || !_hasMoreProducts) return;
    _isLoadingMore = true;

    try {
      List<Modelofproducts> newProducts;
      if (_currentCategoryId == null) {
        newProducts = await _productsApi.getProducts(page: _productsPage);
      } else {
        newProducts = await _categoryProductsApi.getProductsByCategory(_currentCategoryId!);
        // Note: getProductsByCategory might not support pagination in its current API class design, 
        // assuming it returns ALL for now or simple list. 
        // If it sends page, we need to update that class.
        // For now, let's assume standard product api supports category filter too?
        // Actually Apiofproducts().getProducts accepts categoryId.
        if (newProducts.isEmpty) { 
           // Fallback to main API if specific class fails or is limited
           newProducts = await _productsApi.getProducts(categoryId: _currentCategoryId, page: _productsPage);
        }
      }

      if (newProducts.isEmpty) {
        _hasMoreProducts = false;
      } else {
        _allProducts.addAll(newProducts);
        _displayedProducts.addAll(newProducts);
        _productsPage++;
      }

      emit(HomeSuccess(
        products: _displayedProducts,
        categories: _categories,
        offers: _offers,
        hasMoreProducts: _hasMoreProducts,
      ));

    } catch (e) {
      // Don't emit Error state for pagination, just stop loading
      print("Error loading more products: $e");
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> changeCategory(String? categoryId) async {
    _currentCategoryId = categoryId;
    _productsPage = 1;
    _hasMoreProducts = true;
    _allProducts.clear();
    _displayedProducts.clear();
    emit(HomeLoading()); // Show loading indicator while switching

    try {
      if (categoryId == null) {
        _allProducts = await _productsApi.getProducts(page: 1);
      } else {
        // Use the dedicated category API or the filtered product API
        // Using Apiofproducts with categoryId is safer for pagination consistency
         _allProducts = await _productsApi.getProducts(categoryId: categoryId, page: 1);
         // Or use: _allProducts = await _categoryProductsApi.getProductsByCategory(categoryId);
      }
      
      _displayedProducts = List.from(_allProducts);
      _productsPage = 2;

       emit(HomeSuccess(
        products: _displayedProducts,
        categories: _categories,
        offers: _offers,
        hasMoreProducts: _allProducts.isNotEmpty,
      ));
    } catch (e) {
      emit(HomeError("Failed to load category products: $e"));
    }
  }

void searchProducts(String query) {
  List<Modelofproducts> sourceProducts;

  // لو في category محدد، فلتر على المنتجات اللي تحتها فقط
  if (_currentCategoryId != null) {
    sourceProducts = _allProducts;
  } else {
    // لو All، فلتر على المنتجات اللي اتعمل لها load لحد دلوقتي
    sourceProducts = _allProducts.take((_productsPage - 1) * pageSize).toList();
  }

  if (query.isEmpty) {
    _displayedProducts = List.from(sourceProducts);
  } else {
    _displayedProducts = sourceProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  emit(HomeSuccess(
    products: _displayedProducts,
    categories: _categories,
    offers: _offers,
    hasMoreProducts: _hasMoreProducts,
  ));
}

}
