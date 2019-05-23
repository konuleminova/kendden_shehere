import 'package:kendden_shehere/data/model/category_item.dart';
import 'package:kendden_shehere/data/model/product_model.dart';

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
