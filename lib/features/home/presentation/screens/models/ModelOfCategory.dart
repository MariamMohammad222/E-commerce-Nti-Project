class Modelofcategory {
  final String id;
  final String name;
  final String image;
  final String description;
  Modelofcategory({required this.id, required this.name,required this.image,required this.description});
  factory Modelofcategory.fromJson(Map<String, dynamic> json) {
    return Modelofcategory(
      id: json['id'],
      name: json['name'],
      image: json['coverPictureUrl'] ?? '',
      description: json['description'],
    );
  }
}