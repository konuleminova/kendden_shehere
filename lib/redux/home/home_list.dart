import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';

class HomeList {
  List<Home> homelist;

  HomeList({this.homelist});

  factory HomeList.fromJson(List<dynamic> json) {
    List<Home> listCategories = new List<Home>();
    listCategories = json.map((i) => Home.fromJson(i)).toList();
    return HomeList(homelist: listCategories);
  }

  HomeList copyWith({List<Category> listCategories}) {
    return HomeList(homelist: listCategories ?? this.homelist);
  }

  @override
  String toString() {
    return 'HomeList{categories: $homelist}';
  }

}
