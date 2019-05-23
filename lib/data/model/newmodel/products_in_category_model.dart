import 'package:kendden_shehere/data/model/category_item.dart';
import 'package:kendden_shehere/data/model/newmodel/new_product_model.dart';

class ProductsInCategory {
  List<NewProduct> productsInCategory;

  ProductsInCategory({this.productsInCategory});

  factory ProductsInCategory.fromJson(List<dynamic> json) {
    List<NewProduct> photos = new List<NewProduct>();
    photos = json.map((i) => NewProduct.fromJson(i)).toList();
    return ProductsInCategory(productsInCategory: photos);
  }

  ProductsInCategory copyWith({List<NewProduct> productsInCategory}) {
    return ProductsInCategory(productsInCategory: productsInCategory ?? this.productsInCategory);
  }

  @override
  String toString() {
    return 'ProductsInCategory{productsInCategory: $productsInCategory}';
  }
}
