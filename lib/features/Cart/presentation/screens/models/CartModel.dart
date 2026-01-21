class CartItem {
  final String id;
  final String title;
  final double price;
  final double? mrpPrice;
  final String imageUrl;
  final int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    this.mrpPrice,
    required this.imageUrl,
    this.quantity = 1,
  });
}