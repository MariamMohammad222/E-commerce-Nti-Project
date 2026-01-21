import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/home/data/ApiOfProducts.dart';
import 'package:nti_project_final/features/home/data/ApiOfcategories.dart';
import 'package:nti_project_final/features/home/data/ApiOfgetOffers.dart';
import 'package:nti_project_final/features/home/data/getProductsByCategory.dart';
import 'package:nti_project_final/features/home/presentation/cubit/HomeCubit.dart';
import 'package:nti_project_final/features/home/presentation/cubit/HomeState.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfCategory.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/ModelOfproducts.dart';
import 'package:nti_project_final/features/home/presentation/screens/models/modelsOfoffers.dart';
import 'package:nti_project_final/features/home/presentation/widgets/cartWidget.dart';
import 'package:nti_project_final/features/home/presentation/widgets/offerWidet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

int currentIndexx = 0;
PageController _pageController = PageController();
List<Modelofproducts> products = [];
List<Modelofcategory>? Categores = [];
int page = 1;
bool hasMore = true;
bool isLoading = false;
List<OfferModel> offers = [];

int offersPage = 1;
bool hasMoreOffers = true;
bool isLoadingOffers = false;

class _HomescreenState extends State<Homescreen> {
  final PageController _pageController = PageController();
  final TextEditingController _searchController = TextEditingController();
  int _currentCategoryIndex = 0;
 
  @override
  void initState() {
    super.initState();
    // Trigger initial data load
    context.read<HomeCubit>().getHomeData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _currentCategoryIndex == _currentCategoryIndex;


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HomeLoading) {
             return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeSuccess) {
            final offers = state.offers;
            final categories = state.categories;
            final products = state.products;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    Row(
                      children: [
                        Text(
                          'Hi, welcom back',
                          style: Appfonts.textStylepink
                              .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w800),
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications,
                          color: AppColor.primaryColor,
                          size: 30.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    
                    // Search Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _searchController,
                            onChanged: (value) {
                               context.read<HomeCubit>().searchProducts(value);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Theme.of(context).cardColor, // Use card color or inputDecorationTheme.fillColor
                              hintText: 'Search',
                              suffixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
                              hintStyle: Appfonts.textStylegrey.copyWith(
                                  fontSize: 12.sp, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          height: 58.h,
                          width: 55.w,
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.circular(5.r)),
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 30.sp,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 25.h),
                    
                    // Offers Header
                    Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 8.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Special offers',
                              style: Appfonts.textStyleblack.copyWith(
                                  fontSize: 16.sp, 
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Text(
                              'See all',
                              style: Appfonts.textStylepink.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    SizedBox(height: 10.h),
                    
                    // Offers Slider
                    SizedBox(
                      height: 190.h,
                      child: offers.isEmpty
                          ? const Center(child: Text("No offers available"))
                          : PageView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _pageController,
                              itemCount: offers.length,
                              itemBuilder: (context, index) {
                                return Offerwidet(
                                  text1: offers[index].name,
                                  text2: offers[index].description,
                                  imagepath: offers[index].coverUrl,
                                );
                              },
                            ),
                    ),
                    if (offers.isNotEmpty)
SmoothPageIndicator(
  controller: _pageController,
  count: offers.length,
  effect: WormEffect(
    type: WormType.underground,
    radius: 15,
    dotWidth: 12,
    dotHeight: 12,
    activeDotColor: AppColor.primaryColor,
    dotColor: isDark ? Colors.white30 : Colors.grey.shade400,
  ),
)
                    ,
                    
                    SizedBox(height: 15.h),
                    
                    // Recommended Header
                    Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(
                              'Recmmended for you',
                              style: Appfonts.textStyleblack.copyWith(
                                  fontSize: 16.sp, 
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'See all',
                              style: Appfonts.textStylepink.copyWith(
                                  fontSize: 16.sp, fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                    SizedBox(height: 10.h),
                    
                    // Categories Selector
                    SizedBox(
                      height: 50.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length + 1, // +1 for "All"
                        itemBuilder: (context, index) {
                          final bool isAll = index == 0;
                          final String? categoryId =
                              isAll ? null : categories[index - 1].id;

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
  style: ElevatedButton.styleFrom(
    elevation: 0,
    backgroundColor: isSelected
        ? AppColor.primaryColor
        : Theme.of(context).cardColor,
    foregroundColor: isSelected
        ? Colors.white
        : Theme.of(context).textTheme.bodyLarge!.color,
    side: BorderSide(
      color: isSelected
          ? AppColor.primaryColor
          : Colors.grey,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.r),
    ),
  ),
  onPressed: () {
    setState(() {
      _currentCategoryIndex = index;
    });
    context.read<HomeCubit>().changeCategory(categoryId);
    _searchController.clear();
  },
  child: Text(
    isAll ? 'All' : categories[index - 1].name,
    style: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
    ),
  ),
),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 1.h),
                    
                    // Products Grid
                    SizedBox(
                      height: 600.h,
                      child: products.isEmpty
                          ? const Center(child: Text("No products available"))
                          : NotificationListener<ScrollNotification>(
                              onNotification: (scrollInfo) {
                                if (scrollInfo.metrics.pixels >=
                                        scrollInfo.metrics.maxScrollExtent - 100 &&
                                    state.hasMoreProducts) {
                                  context.read<HomeCubit>().loadMoreProducts();
                                }
                                return false;
                              },
                              child: GridView.builder(
                                itemCount: products.length + (state.hasMoreProducts ? 1 : 0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.5,
                                  mainAxisSpacing: 10.h,
                                  crossAxisSpacing: 10.w,
                                ),
                                itemBuilder: (context, index) {
                                  if (index < products.length) {
                                    return Cartwidget(product: products[index]);
                                  } else {
                                    return const Center(child: CircularProgressIndicator());
                                  }
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }
          
          return const Center(child: Text("Something went wrong"));
        },
      ),
    );
  }
}
