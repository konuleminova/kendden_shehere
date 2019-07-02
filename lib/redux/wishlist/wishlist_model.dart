import 'package:kendden_shehere/redux/productlist/new_product_model.dart';

class WishListModel{
  String id;
  String UserId;
  List<NewProduct>list;

  WishListModel({this.id, this.UserId, this.list});

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    var list = json["list"] as List;
    //print(list); //returns List<dynamic>
    List<NewProduct> lists =
    list.map<NewProduct>((json) => NewProduct.fromJson(json)).toList();
    return WishListModel(list: lists);
  }
}