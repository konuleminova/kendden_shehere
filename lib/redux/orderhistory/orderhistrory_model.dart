import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';

class OrderHistoryModel {
  String id;
  String bprice;
  String dtsubmit;
  String status;
  String delivery_price;
 ProductsInCategory list;

  OrderHistoryModel(
      {this.id, this.bprice, this.dtsubmit, this.status, this.list,this.delivery_price});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    return new OrderHistoryModel(
        id: json['id'],
        bprice: json['bprice'],
        dtsubmit: json['dtsubmit'],
        status: json['status'],
        delivery_price: json['delivery_price'],
        list: ProductsInCategory.fromJson(json['list']));
  }
}
