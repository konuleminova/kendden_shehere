import 'package:kendden_shehere/data/model/category_item.dart';

class ListCategories {
  List<Category> categories;

  ListCategories({this.categories});

  factory ListCategories.fromJson(List<dynamic> json) {
    var list = json as List;
    //print(list); //returns List<dynamic>
    List<Category> photos = new List<Category>();
    List<Category> lists =
        list.map<Category>((json) => Category.fromJson(json)).toList();
    photos = json.map((i) => Category.fromJson(i)).toList();
    return ListCategories(categories: photos);
  }

  ListCategories copyWith({List<Category> listCategories}) {
    return ListCategories(categories: listCategories ?? this.categories);
  }

  @override
  String toString() {
    return 'ListCategories{categories: $categories}';
  }
}
