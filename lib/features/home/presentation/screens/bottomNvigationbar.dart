import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti_project_final/features/AddProduct/presentation/screens/addproduct.dart';
import 'package:nti_project_final/features/Cart/presentation/screens/cartScreen.dart';
import 'package:nti_project_final/features/Setting/presentation/screens/SettingScreen.dart';
import 'package:nti_project_final/features/home/presentation/cubit/HomeCubit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/favorites/presentation/screens/favorits.dart';
import 'package:nti_project_final/features/home/presentation/screens/homeScreen.dart';

class HomwScreen extends StatefulWidget {
  const HomwScreen({super.key});

  @override
  State<HomwScreen> createState() => _HomwScreenState();
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class _HomwScreenState extends State<HomwScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: PersistentTabView(
          context,
          controller: _controller,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Dynamic background
          screens: [
            Homescreen(),
            FavoritesGridScreen(),
            AddProductScreen(),
            CartPage(),
            SettingScreen(),
          ],
          items: [
            PersistentBottomNavBarItem(
              icon: Icon(Icons.home),
              title: "Home",
              activeColorPrimary: AppColor.primaryColor,
              inactiveColorPrimary: Theme.of(context).iconTheme.color ?? Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.favorite),
              title: "Favorites",
              activeColorPrimary: AppColor.primaryColor,
              inactiveColorPrimary: Theme.of(context).iconTheme.color ?? Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.add_box),
              title: "Add Product",
              activeColorPrimary: AppColor.primaryColor,
              inactiveColorPrimary: Theme.of(context).iconTheme.color ?? Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.shopping_cart),
              title: "Cart",
              activeColorPrimary: AppColor.primaryColor,
              inactiveColorPrimary: Theme.of(context).iconTheme.color ?? Colors.grey,
            ),
            PersistentBottomNavBarItem(
              icon: Icon(Icons.settings),
              title: "Settings",
              activeColorPrimary: AppColor.primaryColor,
              inactiveColorPrimary: Theme.of(context).iconTheme.color ?? Colors.grey,
            ),
          ],
          navBarStyle: NavBarStyle.style3,
        ),
      ),
    );
  }
}
