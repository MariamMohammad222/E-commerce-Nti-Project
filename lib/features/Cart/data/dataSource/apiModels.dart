class CartResponse {
  final String cartId;
  final List<CartItemApi> cartItems;

  CartResponse({
    required this.cartId,
    required this.cartItems,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    return CartResponse(
      cartId: json['cartId'] ?? '',
      cartItems: (json['cartItems'] as List? ?? [])
          .map((item) => CartItemApi.fromJson(item))
          .toList(),
    );
  }

  double get subtotal => cartItems.fold(0, (sum, item) => sum + item.totalPrice);
}

class CartItemApi {
  final String itemId;
  final String productId;
  final String productName;
  final String productCoverUrl;
  final int productStock;
  final double weightInGrams;
  final int quantity;
  final double discountPercentage;
  final double basePricePerUnit;
  final double finalPricePerUnit;
  final double totalPrice;

  CartItemApi({
    required this.itemId,
    required this.productId,
    required this.productName,
    required this.productCoverUrl,
    required this.productStock,
    required this.weightInGrams,
    required this.quantity,
    required this.discountPercentage,
    required this.basePricePerUnit,
    required this.finalPricePerUnit,
    required this.totalPrice,
  });

  factory CartItemApi.fromJson(Map<String, dynamic> json) {
    return CartItemApi(
      itemId: json['itemId'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      productCoverUrl: json['productCoverUrl'] ?? '',
      productStock: json['productStock'] ?? 0,
      weightInGrams: (json['weightInGrams'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
      basePricePerUnit: (json['basePricePerUnit'] ?? 0).toDouble(),
      finalPricePerUnit: (json['finalPricePerUnit'] ?? 0).toDouble(),
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
    );
  }
}
class ProductResponse {
  final List<Modelofproducts> items;
  final int totalCount;

  ProductResponse({required this.items, required this.totalCount});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      items: (json['items'] as List? ?? [])
          .map((item) => Modelofproducts.fromJson(item))
          .toList(),
      totalCount: json['totalCount'] ?? 0,
    );
  }
}

class Modelofproducts {
  final String id;
  final String name;
  final String image;
  final double price;
  final String description;
  final double rate;
  final List<String> ?categories;
  final int? stock;
  final double? weight;
  final String? color;
  final double? rating;
  final int? reviewsCount;
  final double? discountPercentage;

  Modelofproducts({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
    required this.rate,
     this.categories,
    this.stock,
    this.weight,
    this.color,
    this.rating,
    this.reviewsCount,
    this.discountPercentage,
  });

  factory Modelofproducts.fromJson(Map<String, dynamic> json) {
    return Modelofproducts(
      id: json['id'] ?? '',
      name: json['arabicName'] ?? '', // أو json['name'] للاسم الإنجليزي
      image: json['coverPictureUrl'] ?? '',
      price: (json['price']?.toDouble()) ?? 0.0,
      description: json['description'] ?? '',
      rate: (json['rating']?.toDouble()) ?? 0.0,
      categories: List<String>.from(json['categories'] ?? []),
      stock: json['stock'],
      weight: (json['weight'] ?? 0).toDouble(),
      color: json['color'],
      rating: (json['rating'] ?? 0).toDouble(),
      reviewsCount: json['reviewsCount'],
      discountPercentage: (json['discountPercentage'] ?? 0).toDouble(),
    );
  }
}
