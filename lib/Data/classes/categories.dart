class Category {
  int catigoryCode;
  String? categoryName;

  Category(this.categoryName, this.catigoryCode);

  static List<Category> catigories = [
    Category('All', 0),
    Category('facebook', 1),
    Category('instagram', 2),
    Category('twitter', 3),
  ];
}
