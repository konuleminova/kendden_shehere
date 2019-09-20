import 'package:kendden_shehere/redux/orderhistory/orderhistrory_model.dart';

class OrderHistoryListModel{
  List<OrderHistoryModel>orderList;

  OrderHistoryListModel({this.orderList});
  factory OrderHistoryListModel.fromJson(List<dynamic>json){
    List<OrderHistoryModel> orderHList=new List();
    orderHList=json.map((i)=>new OrderHistoryModel.fromJson(i)).toList();
    return OrderHistoryListModel(orderList: orderHList);
  }

  @override
  String toString() {
    return 'OrderHistoryListModel{orderList: $orderList}';
  }


}