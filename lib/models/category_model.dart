class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Convert a map into a Category object
  // factory Category.fromMap(Map<String, dynamic> map) {
  //   return Category(
  //     id: map['id'],
  //     name: map['name'],
  //     imageUrl: map['imageUrl'][1],
  //   );
  // }

  // // Convert a Category object into a map
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //   };
  // }
}
