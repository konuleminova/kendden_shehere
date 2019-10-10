import 'package:kendden_shehere/redux/productlist/new_product_model.dart';

class RemoveWishItemAction {
  List<NewProduct> wishItems;
  NewProduct removeWishItem;

  RemoveWishItemAction({this.wishItems, this.removeWishItem});
}

class AddWishItemAction {
  NewProduct product;

  AddWishItemAction({this.product});
}
class FetchWishListAction {
  List<NewProduct> data;
  FetchWishListAction({this.data});
}
