import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nti_project_final/core/constants/appFonts.dart';
import 'package:nti_project_final/core/theme/app_colors.dart';
import 'package:nti_project_final/features/Cart/data/dataSource/CartCubit.dart';
import 'package:nti_project_final/features/Cart/presentation/screens/models/CartModel.dart';
import 'package:nti_project_final/features/Cart/presentation/screens/widgets/cartItemWidget.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartCubit>().fetchCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.simpleCurrency(decimalDigits: 0);
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return BlocBuilder<CartCubit, List<CartItem>>(
      builder: (context, items) {
        final cubit = context.read<CartCubit>();
        final total = cubit.subtotal;

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cart',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w400, color: textColor),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.shopping_cart,
                  color: AppColor.primaryColor,
                  size: 28,
                ),
              ],
            ),
            centerTitle: true,
            actions: const [SizedBox(width: 48)],
          ),
          body: Column(
            children: [
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          'Your cart is empty',
                          style: TextStyle(color: textColor, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return CartItemWidget(
                            item: items[index],
                            onIncrement: () => cubit.incrementQuantity(
                                items[index].id, items[index].quantity),
                            onDecrement: () => cubit.decrementQuantity(
                                items[index].id, items[index].quantity),
                            onDelete: () => _confirmDelete(
                                context, index, items[index].title),
                          );
                        },
                      ),
              ),
              _buildBottomSection(context, currencyFormat, total, items.isNotEmpty),
            ],
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, int index, String title) {
    final cubit = context.read<CartCubit>();
    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Delete Item', style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
        content: Text(
          'Are you sure you want to remove "$title"?',
          style: TextStyle(color: textColor, fontSize: 16),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              cubit.removeItem(cubit.state[index].id);
              Navigator.of(ctx).pop();
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context, NumberFormat currencyFormat, double total, bool hasItems) {
    if (!hasItems) return const SizedBox.shrink();

    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: Theme.of(context).brightness == Brightness.light
            ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)]
            : [],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Subtotal : ', style: TextStyle(color: textColor, fontSize: 18)),
                Text(currencyFormat.format(total),
                    style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Your order is eligible for free delivery',
              style: TextStyle(color: textColor, fontSize: 14),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 180,
              height: 48,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text('Checkout', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
