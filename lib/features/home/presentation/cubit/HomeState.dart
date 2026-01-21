import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfCategory.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/modelsOfoffers.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Modelofproducts> products;
  final List<Modelofcategory> categories;
  final List<OfferModel> offers;
  final bool hasMoreProducts;

  HomeSuccess({
    required this.products,
    required this.categories,
    required this.offers,
    this.hasMoreProducts = true,
  });
}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}

// Optional: State specifically for search updates if we want to differentiate
class HomeSearchUpdate extends HomeState {
  final List<Modelofproducts> filteredProducts;
  HomeSearchUpdate(this.filteredProducts);
}
