import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kendden_shehere/redux/app/app_state_model.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/redux/home/home_model.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/information/information.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/common/model/product_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/new_product_model.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/register/register_model.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/redux/wishlist/wishlist_model.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class Networks {
  static final String BASE_URL = "http://35.240.80.11/app/";
  static String LOGIN_ENDPOINT = "login/";
  static String FETCH_PRODUCT =
      "https://pulapul.com/PulaPul/?action=GetCampaignList";
  static SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();

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

  // static String LIST_CATEGORIES = BASE_KS_URL + "list_categories";
//  static var PRODUCTS_IN_CATEGORY = BASE_KS_URL + "productincat&id=";
  ///static var BANNER_IMAGES = BASE_KS_URL + "bannerimages";
  // static var WISH_LIST = BASE_KS_URL + "wishlist";
  //static var SEARCH = BASE_KS_URL + "search";
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
      final response = await http.get(BASE_KS_URL + "list_categories");
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
      final response = await http.get(BASE_KS_URL +
          "productincat&id=" +
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
      final response = await http.get(BASE_KS_URL + "bannerimages");
      if (response.statusCode == 200) {
        List<String> photos =
            json.decode(response.body).map<String>((m) => m as String).toList();
        return photos;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic wishList() async {
    try {
      var id = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response = await http.get(BASE_KS_URL + "wishlist" + "&id=${id}");
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
      final response = await http.get(BASE_KS_URL +
          "search" +
          "&q=${query}+&start=${0}+&limit=${100}+&lang=${lang}");
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
    final response = await http.get(BASE_KS_URL +
        "register" +
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

  static getCollections() async {
    try {
      final response = await http.get(BASE_KS_URL + "collection" + "&inf");
      if (response.statusCode == 200) {
        print(".. HOME collection");
        return ProductsInCategory.fromJson(json.decode(response.body))
            .productsInCategory;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static getCollectionItem(String id) async {
    try {
      final response =
          await http.get(BASE_KS_URL + "collection" + "&inf=${id}");

      if (response.statusCode == 200) {
        print(id + ".. HOME");
        // print(response.body);
        List<NewProduct> pro =
            ProductsInCategory.fromJson(json.decode(response.body))
                .productsInCategory;
        return pro;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static orderHistory() async {
    try {
      var id = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response =
          await http.get(BASE_KS_URL + "orderhistory" + "&id=${id}");
      print("Order history");
      // print(id + ".. product id ");
      if (response.statusCode == 200) {
        return OrderHistoryListModel.fromJson(json.decode(response.body))
            .orderList;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic basket() async {
    try {
      var id = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response = await http.get(BASE_KS_URL + "basket" + "&uid=${id}");
      print(response.body.toString());
      if (response.statusCode == 200) {
        OrderHistoryListModel order =
            OrderHistoryListModel.fromJson(json.decode(response.body));
        print(order);
        var a = json.decode(response.body) as List;
        print("BASKET");
        if (a[0]['hasAlchocol'][0] != null) {
          await sharedPrefUtil.setString(
              SharedPrefUtil.alkaqol, a[0]['hasAlchocol'][0]);
        }
        print(a[0]['hasAlchocol'][0]);
        await sharedPrefUtil.setString(
            SharedPrefUtil.id, order.orderList[0].id);
        return OrderHistoryListModel.fromJson(json.decode(response.body));
      } else {
        return "500";
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
      final response = await http
          .get(BASE_KS_URL + "information&inf=delivery" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body) as List;

        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic aboutus(String lang) async {
    try {
      final response = await http
          .get(BASE_KS_URL + "information&inf=aboutus" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body) as List;

        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic contacts(String lang) async {
    try {
      final response = await http
          .get(BASE_KS_URL + "information&inf=contacts" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);

        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic updateUser(
      BuildContext context, String inf, String data) async {
    try {
      var uid = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response = await http.get(BASE_KS_URL +
          "updateuser&uid=${uid}" +
          "&inf=${inf}" +
          "&data=${data}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        Navigator.pop(context);
        sharedPrefUtil.setString(inf, data);
        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static userinfo() async {
    try {
      var uid = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response = await http.get(BASE_KS_URL + "userinfo&id=${uid}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body) as List;
        print(a[1]['id']);
        print("USER INFO");
        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic add_Remove_WishList(String id) async {
    try {
      var uid = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response =
          await http.get(BASE_KS_URL + "addtowishlist&uid=${uid}&id=${id}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic addToBasket(String id, String weight) async {
    try {
      var uid = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response = await http.get(
          BASE_KS_URL + "addtobasket&uid=${uid}&id=${id}&weight=${weight}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic removeFromBasket(String id) async {
    try {
      var uid = await sharedPrefUtil.getString(SharedPrefUtil.uid);
      final response =
          await http.get(BASE_KS_URL + "removefrombasket&uid=${uid}&id=${id}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }

  static dynamic finishBasket(Checkout checkout) async {
    print("BASKEt");
    print(checkout);
    try {
      var uid = await sharedPrefUtil.getString(
        SharedPrefUtil.uid,
      );
      final response = await http.get(
        BASE_KS_URL +
            "finishbasket&uid=${uid}&id=${checkout.id}&address=${checkout.address}&delivery_place=${checkout.delivery_place}"
                "&mobile=${checkout.mobile}&dtime_selected_val=${checkout.dtime_selected_val}"
                "&username=${checkout.username}&delivery_price=${checkout.username}&dpayment_selected_val=${checkout.dpayment_selected_val}",
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        print(a);
        return a;
      } else {
        return null;
      }
    } catch (exception) {}
  }
}
