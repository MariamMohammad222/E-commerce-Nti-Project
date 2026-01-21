import 'package:flutter/material.dart';
import 'package:nti_project_final/features/favorites/presentation/widgets/cartitem.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';
import 'package:nti_project_final/features/home/presentation/widgets/cartWidget.dart';



class FavoritesGridScreen extends StatefulWidget {
  const FavoritesGridScreen({super.key});

  @override
  State<FavoritesGridScreen> createState() => _FavoritesGridScreenState();
}

class _FavoritesGridScreenState extends State<FavoritesGridScreen> {
  static const Color primaryColor = Color(0xFFE20075);

  void removeFromFavorites(Modelofproducts product) {
    setState(() {
      FavoritesManager.toggleFavorite(product);
    });
  }

   void addtoFavorites(Modelofproducts product) {
    setState(() {
      FavoritesManager.toggleFavorite(product);
    });
  }
  

 

  @override
  Widget build(BuildContext context) {
    final favorites = FavoritesManager.favorites;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(centerTitle: true,
        title: const Text(
          'Favorites',

        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: ValueListenableBuilder<List<Modelofproducts>>(
  valueListenable: FavoritesManager.favoritesNotifier,
  builder: (context, favorites, _) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) {
        final product = favorites[index];
        return FavoriteItemCard(
          product: product,
          onAdd: () => FavoritesManager.toggleFavorite(product),
          onRemove: () => FavoritesManager.toggleFavorite(product),
        );
      },
    );
  },
)

      
    );
  }
}
