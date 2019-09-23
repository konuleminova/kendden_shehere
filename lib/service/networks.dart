import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/information/information.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/login/thunk_login.dart';
import 'package:kendden_shehere/redux/qsearch/list_qsearch.dart';
import 'package:kendden_shehere/redux/qsearch/qsearch_model.dart';
import 'package:kendden_shehere/redux/register/register_model.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_model.dart';

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
  static var WISH_LIST = BASE_KS_URL + "wishlist";
  static var SEARCH = BASE_KS_URL + "search";
  static var REGISTER = BASE_KS_URL + "register";

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
      print(id + ".. product id ");
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

  static dynamic wishList(String id) async {
    try {
      final response = await http.get(WISH_LIST + "&id=${id}");
      if (response.statusCode == 200) {
        print("code");
        return List_Wish_Model.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic search(String lang, String query) async {
    try {
      final response = await http
          .get(SEARCH + "&q=${query}+&start=${0}+&limit=${100}+&lang=${lang}");
      print("code");
      print(response.statusCode);
      print(response.toString());
      if (response.statusCode == 200) {
        return ProductsInCategory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic qsearch(String lang, String query) async {
    try {
      final response = await http.get(BASE_KS_URL +
          "qsearch" +
          "&q=${query}+&start=${0}+&limit=${100}+&lang=${lang}");
      print("code");
      print(response.statusCode);
      print(response.toString());
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return ProductsInCategory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static Future<RegisterModel> register(
      String lang, UserModel userModel) async {
    final response = await http.get(REGISTER +
        "&lang=${lang}+&login=${userModel.username}+&name=${userModel.name}+&surname=${userModel.surname}"
            "+&mobile=${userModel.mobile}+&pass=${userModel.password}"
            "+&pass2=${userModel.password2}");
    if (response.statusCode == 200) {
      print("code");
      print(json.decode(response.body));
//        print(RegisterModel.fromJson(json.decode(response.body)).login);
      print('IF WORKS');
      print('RESPONSE: --> ${response.body}');
      print('JSON RESPONSE: --> ${jsonDecode(response.body)}');
      return RegisterModel.fromJson(json.decode(response.body));
    } else {
      print('ELSE WORKS');
      return null;
    }
  }

  static dynamic getCollections() async {
    try {
      final response = await http.get(BASE_KS_URL + "collection" + "&inf");
      if (response.statusCode == 200) {
        return ProductsInCategory.fromJson(json.decode(response.body))
            .productsInCategory;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic getCollectionItem(String id) async {
    try {
      final response =
          await http.get(BASE_KS_URL + "collection" + "&inf=${id}");
      //  print(id + ".. product id ");
      if (response.statusCode == 200) {
        // print(response.body);
        return ProductsInCategory.fromJson(json.decode(response.body))
            .productsInCategory;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic orderHistory(String id) async {
    try {
      final response =
          await http.get(BASE_KS_URL + "orderhistory" + "&id=${id}");
      print(id + ".. product id ");
      if (response.statusCode == 200) {
        return OrderHistoryListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic basket(String uid) async {
    try {
      final response = await http.get(BASE_KS_URL + "basket" + "&uid=${uid}");
      print(uid + ".. product id ");
      if (response.statusCode == 200) {
        return OrderHistoryListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic fag(String lang) async {
    try {
      final response =
          await http.get(BASE_KS_URL + "information&inf=faq" + "&lang=${lang}");
      if (response.statusCode == 200) {
        return ListInfo.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }
  static dynamic delivery(String lang) async {
    try {
      final response =
      await http.get(BASE_KS_URL + "information&inf=delivery" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a=json.decode(response.body) as List;

        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }
  static dynamic aboutus(String lang) async {
    try {
      final response =
      await http.get(BASE_KS_URL + "information&inf=aboutus" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a=json.decode(response.body) as List;

        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }
}
