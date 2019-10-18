import 'package:kendden_shehere/redux/productlist/product_model.dart';

class WishListModel{
  String id;
  String UserId;
  List<Product>list;

  WishListModel({this.id, this.UserId, this.list});

  factory WishListModel.fromJson(Map<String, dynamic> json) {
    var list = json["list"] as List;
    //print(list); //returns List<dynamic>
    List<Product> lists =
    list.map<Product>((json) => Product.fromJson(json)).toList();
    return WishListModel(list: lists);
  }
}