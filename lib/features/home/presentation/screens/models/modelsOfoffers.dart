class OfferModel {
  final String ?id;
  final String name;
  final String description;
  final String coverUrl;

  OfferModel({
     this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverUrl: json['coverUrl'],
    );
  }
}
