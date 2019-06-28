import 'package:kendden_shehere/redux/model/product_model.dart';

class RemoveWishItemAction {
  List<Product> wishItems;
  Product removeWishItem;

  RemoveWishItemAction({this.wishItems, this.removeWishItem});
}

class AddWishItemAction {
  Product product;

  AddWishItemAction({this.product});
}
