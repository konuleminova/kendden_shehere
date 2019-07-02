import 'package:kendden_shehere/redux/wishlist/wishlist_model.dart';

class List_Wish_Model {
  List<WishListModel> productsInCategory;
  List_Wish_Model({this.productsInCategory});

  factory List_Wish_Model.fromJson(List<dynamic> json) {
    List<WishListModel> products = new List<WishListModel>();
    products = json.map((i) => WishListModel.fromJson(i)).toList();
    return List_Wish_Model(productsInCategory: products);
  }

  List_Wish_Model copyWith({List<WishListModel> productsInCategory}) {
    return List_Wish_Model(productsInCategory: productsInCategory ?? this.productsInCategory);
  }

  @override
  String toString() {
    return 'List_Wish_Model{productsInCategory: $productsInCategory}';
  }
}
