import 'package:kendden_shehere/data/model/product_model.dart';

class Home {
  String result;
  List<Product> data;
  Product product;

  Home({this.result, this.data,this.product});

  factory Home.fromJson(Map<String, dynamic> json) {
    var list = json["DATA"] as List;
    print(list); //returns List<dynamic>
    List<Product> lists =
        list.map<Product>((json) => Product.fromJson(json)).toList();
    return Home(result: json["RESULT"], data: lists);
  }

  Home copyWith({String result, List<Product> data,Product product}) {
    return Home(result: result ?? this.result, data: data ?? this.data,product: product??this.product);
  }

  @override
  String toString() {
    return 'Home{result: $result, data: $data}';
  }
}
