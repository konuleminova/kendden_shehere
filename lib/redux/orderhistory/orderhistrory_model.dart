import 'package:kendden_shehere/redux/productlist/product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';

class OrderHistoryModel {
  String basket;
  String id;
  String bprice;
  String dtsubmit;
  String status;
  String delivery_price;
  String payment_status;
  ProductsInCategory list;

  OrderHistoryModel(
      {this.id,
      this.bprice,
      this.dtsubmit,
      this.status,
      this.list,
      this.delivery_price,
      this.basket,
      this.payment_status});

  OrderHistoryModel.fromJson(Map<String, dynamic> json)
      : basket = json['basket'] ?? '',
        id = json['id'] ?? "",
        payment_status = json['payment_status']??"",
        bprice = json['bprice'] ?? "",
        dtsubmit = json['dtsubmit'] ?? "",
        status = json['status'] ?? "",
        delivery_price = json['delivery_price'] ?? "",
        list = ProductsInCategory.fromJson(json['list']) ?? [];

  @override
  String toString() {
    return 'OrderHistoryModel{id: $id, bprice: $bprice, dtsubmit: $dtsubmit, status: $status, delivery_price: $delivery_price, list: $list}';
  }
}
