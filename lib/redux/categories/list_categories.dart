import 'package:kendden_shehere/redux/categories/category_item.dart';


class ListCategories {
  List<Category> categories;

  ListCategories({this.categories});

  factory ListCategories.fromJson(List<dynamic> json) {
    List<Category> listCategories = new List<Category>();
    listCategories = json.map((i) => Category.fromJson(i)).toList();
    return ListCategories(categories: listCategories);
  }

  ListCategories copyWith({List<Category> listCategories}) {
    return ListCategories(categories: listCategories ?? this.categories);
  }

  @override
  String toString() {
    return 'ListCategories{categories: $categories}';
  }
}
