import 'package:kendden_shehere/redux/productlist/product_model.dart';

class RemoveWishItemAction {
  List<Product> wishItems;
  Product removeWishItem;

  RemoveWishItemAction({this.wishItems, this.removeWishItem});
}

class AddWishItemAction {
  Product product;

  AddWishItemAction({this.product});
}
class FetchWishListAction {
  List<Product> data;
  FetchWishListAction({this.data});
}
