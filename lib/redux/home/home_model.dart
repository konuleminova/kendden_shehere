import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';

class Home {
  String id;
  String name_az;
  String name_en;
  String name_ru;
  List<Product> list;

  Home({this.id, this.name_az, this.name_en, this.name_ru, this.list});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
        id: json["id"],
        name_az: json["name_az"],
        name_en: json["name_en"],
        name_ru: json["name_ru"],
        list: ProductsInCategory.fromJson(json['list']).productsInCategory);
  }

  @override
  String toString() {
    return 'Home{id: $id, name_az: $name_az, name_en: $name_en, name_ru: $name_ru, list: $list}';
  }

}
