import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/model/product_model.dart';
import 'package:kendden_shehere/redux/categories/products_in_category_model.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';

class Networks {
  static final String BASE_URL = "http://35.240.80.11/app/";
  static String LOGIN_ENDPOINT = "login/";
  static String FETCH_PRODUCT =
      "https://pulapul.com/PulaPul/?action=GetCampaignList";

//Pulapul Pictofy Api

  /* static dynamic loginUser(String username, String password) async {
    var uri = BASE_URL + LOGIN_ENDPOINT;
    try {
      final response = await http.post(uri,
          body: json.encode({
            'username': username,
            'password': password,
          }),
          headers: {"Accept": "application/json"});
      print(response.statusCode.toString() + "..");
      if (response.statusCode == 200) {
        return AppState.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
      {
        return null;
      }
    }
  }
*/
  static dynamic fetchProducts(int limit, int page) async {
    try {
      final response = await http.post(FETCH_PRODUCT,
          body: json.encode({
            "ID": "71",
            "ROWS": {"LIMIT": limit, "PAGE": page}
          }),
          headers: {"Accept": "application/json"});
      if (response.statusCode == 200) {
        return Home.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

//Kendden Shehere APIs
  static String BASE_KS_URL = "http://kenddenshehere.az/api/?act=";
  static String LIST_CATEGORIES = BASE_KS_URL + "list_categories";
  static var PRODUCTS_IN_CATEGORY = BASE_KS_URL + "productincat&id=";
  static var BANNER_IMAGES = BASE_KS_URL + "bannerimages";

  static dynamic login(String username, String password) async {
    String LOGIN = BASE_KS_URL + "login&l=" + username + "&p=" + password;
    try {
      final response = await http.get(LOGIN);
      print(response.statusCode.toString() + "..");
      if (response.statusCode == 200) {
        return UserModel.fromJson(json.decode(response.body)[0]);
      } else {
        return null;
      }
    } catch (exception) {
      {
        return null;
      }
    }
  }

  static dynamic listCategories() async {
    try {
      final response = await http.get(LIST_CATEGORIES);
      if (response.statusCode == 200) {
        return ListCategories.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic productsInCategory(
      String id, String order, String lang, String limit, String start) async {
    try {
      final response = await http.get(PRODUCTS_IN_CATEGORY +
          id +
          "&order=${order}&lang=${lang}&limit=${limit}&start=${start}");
      print(id+".. product id ");
      if (response.statusCode == 200) {
        return ProductsInCategory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic bannerImages() async {
    try {
      final response = await http.get(BANNER_IMAGES);
      if (response.statusCode == 200) {
        List<String> photos =
            json.decode(response.body).map<String>((m) => m as String).toList();
        return photos;
      } else {
        return null;
      }
    } catch (exception) {}
  }
}
