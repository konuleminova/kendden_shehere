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
    return new OrderHistoryModel(
        id: json['id'],
        bprice: json['bprice'],
        dtsubmit: json['dtsubmit'],
        status: json['status']);
  }
}
