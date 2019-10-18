import 'package:kendden_shehere/redux/productlist/product_model.dart';

class ProductsInCategory {
  List<Product> productsInCategory;
  ProductsInCategory({this.productsInCategory});

  factory ProductsInCategory.fromJson(List<dynamic> json) {
    List<Product> products = new List<Product>();
    products = json.map((i) => Product.fromJson(i)).toList();
    return ProductsInCategory(productsInCategory: products);
  }

  ProductsInCategory copyWith({List<Product> productsInCategory}) {
    return ProductsInCategory(productsInCategory: productsInCategory ?? this.productsInCategory);
  }

  @override
  String toString() {
    return 'ProductsInCategory{productsInCategory: $productsInCategory}';
  }
}
