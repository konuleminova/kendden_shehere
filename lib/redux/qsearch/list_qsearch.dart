import 'package:kendden_shehere/redux/categories/category_item.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/qsearch/qsearch_model.dart';

class ListQSearch {
  List<QSearchModel> qsearchList;

  ListQSearch({this.qsearchList});

  factory ListQSearch.fromJson(List<dynamic> json) {
    List<QSearchModel> listCategories = new List<QSearchModel>();
    listCategories = json.map((i) => QSearchModel.fromJson(i)).toList();
    return ListQSearch(qsearchList: listCategories);
  }

  ListQSearch copyWith({List<QSearchModel> listCategories}) {
    return ListQSearch(qsearchList: listCategories ?? this.qsearchList);
  }

  @override
  String toString() {
    return 'ListCategories{categories: $qsearchList}';
  }
}
