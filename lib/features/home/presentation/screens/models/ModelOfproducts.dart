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
      name: json['arabicName'] ?? json['name'] ?? '', 
      image: json['coverPictureUrl'] ?? json['image'] ?? '',
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
