class Category {
  String? title;
  String? image;

  Category({required this.title, this.image});
}

List<Category> categories = [
  Category(title: 'Sofas', image: 'images/c_images/sofas.jpg'),
  Category(title: 'Table', image: 'images/c_images/table.jpg'),
  Category(title: 'Beds', image: 'images/c_images/beds.jpg'),
  Category(
      title: 'Dining Furniture', image: 'images/c_images/dining_furniture.jpg'),
  Category(title: 'Shelving Furniture', image: 'images/c_images/shelf.jpg'),
  Category(title: 'Plants', image: 'images/c_images/plants.jpg'),
  Category(
      title: 'Outdoor Furniture',
      image: 'images/c_images/outdoor_furniture.jpg'),
];
