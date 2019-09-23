import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/information/info.dart';

class ListInfo {
  List<Info> info;

  ListInfo({this.info});

  factory ListInfo.fromJson(List<dynamic> json) {
    List<Info> listCategories = new List<Info>();
    listCategories = json.map((i) => Info.fromJson(i)).toList();
    return ListInfo(info: listCategories);
  }
}
