import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';

class OrderHistoryModel {
  String id;
  String bprice;
  String dtsubmit;
  String status;
 ProductsInCategory list;

  OrderHistoryModel(
      {this.id, this.bprice, this.dtsubmit, this.status, this.list});

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    return new OrderHistoryModel(
        id: json['id'],
        bprice: json['bprice'],
        dtsubmit: json['dtsubmit'],
        status: json['status'],
        list: ProductsInCategory.fromJson(json['list']));
  }
}
