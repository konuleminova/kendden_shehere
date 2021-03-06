import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:kendden_shehere/constants/Constants.dart';
import 'package:kendden_shehere/redux/checkout/checkout.dart';
import 'package:kendden_shehere/redux/categories/list_categories.dart';
import 'package:kendden_shehere/redux/home/home_list.dart';
import 'package:kendden_shehere/redux/information/information.dart';
import 'package:kendden_shehere/redux/login/user_model.dart';
import 'package:kendden_shehere/redux/orderhistory/orderhistory_listmodel.dart';
import 'package:kendden_shehere/redux/productlist/products_in_category_model.dart';
import 'package:kendden_shehere/redux/register/register_model.dart';
import 'package:kendden_shehere/redux/wishlist/list_wish_model.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

class Networks {
  Networks._privateConstructor();

  static final Networks _instance = Networks._privateConstructor();

  factory Networks() {
    return _instance;
  }

//Kendden Shehere APIs
  String BASE_KS_URL = "http://kenddenshehere.az/api/?act=";
  dynamic login(String username, String password) async {
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
       // debugPrint(exception);
        return null;
      }
    }
  }

  dynamic listCategories() async {
    try {
      final response = await http.get(BASE_KS_URL + "list_categories");
      print("List Categoreis");
      if (response.statusCode == 200) {
        return ListCategories.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic productsInCategory(
      String id, String order, String lang, String limit, String start) async {
    try {
      print("Product in cat");
      print("PRoduct:" + id);
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
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic bannerImages() async {
    try {
      print("Product in cat");
      final response = await http.get(BASE_KS_URL + "bannerimages");
      print("Banner Images");
      if (response.statusCode == 200) {
        List<String> photos =
            json.decode(response.body).map<String>((m) => m as String).toList();
        return photos;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic wishList() async {
    print("Wish List");
    try {
      var id = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response = await http.get(BASE_KS_URL + "wishlist" + "&id=${id}");
      if (response.statusCode == 200) {
        return List_Wish_Model.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic search(String lang, String query, String start) async {
    try {
      print("Search");
      final response = await http.get(BASE_KS_URL +
          "search" +
          "&q=${query}+&start=${start}+&limit=${30}+&lang=${lang}");
      if (response.statusCode == 200) {
        return ProductsInCategory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic qsearch(String lang, String query) async {
    try {
      print("Qsearch");
      final response = await http.get(BASE_KS_URL +
          "qsearch" +
          "&q=${query}+&start=${0}+&limit=${100}+&lang=${lang}");
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return ProductsInCategory.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  Future<RegisterModel> register(String lang, UserModel userModel) async {
    final response = await http.get(BASE_KS_URL +
        "register" +
        "&lang=${lang}+&login=${userModel.username}+&name=${userModel.name}+&surname=${userModel.surname}"
            "+&mobile=${userModel.mobile}+&pass=${userModel.password}"
            "+&pass2=${userModel.password2}");
    if (response.statusCode == 200) {
      return RegisterModel.fromJson(json.decode(response.body));
    } else {
     // print('ELSE WORKS');
      return null;
    }
  }

//  getCollections() async {
//    try {
//      final response = await http.get(BASE_KS_URL + "collection" + "&inf");
//      if (response.statusCode == 200) {
//        return ProductsInCategory.fromJson(json.decode(response.body));
//      } else {
//        return null;
//      }
//    } catch (exception) {}
//  }
//
//  getCollectionItem(String id) async {
//    try {
//      final response =
//          await http.get(BASE_KS_URL + "collection" + "&inf=${id}");
//
//      if (response.statusCode == 200) {
//        print(id + ".. HOME");
//        // print(response.body);
//        List<Product> pro =
//            ProductsInCategory.fromJson(json.decode(response.body))
//                .productsInCategory;
//        return pro;
//      } else {
//        return null;
//      }
//    } catch (exception) {}
//  }

  orderHistory() async {
    print("Order history");
    try {
      var id = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response =
          await http.get(BASE_KS_URL + "orderhistory" + "&id=${id}");
      if (response.statusCode == 200) {
        return OrderHistoryListModel.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic basket() async {
    try {
     // print("Basket");

      var id = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response = await http.get(BASE_KS_URL + "basket" + "&uid=${id}");
      if (response.statusCode == 200) {
        print("200");
        var basket = json.decode(response.body)[0]['basket'];
        print(json.decode(response.body)[0]['basket']);
        if (basket == '1') {
          OrderHistoryListModel order =
              OrderHistoryListModel.fromJson(json.decode(response.body));
          var a = json.decode(response.body) as List;
          if (a.length > 0) {
            if (a[0]['hasAlchocol'][0] != null) {
              await SharedPrefUtil()
                  .setString(SharedPrefUtil().alkaqol, a[0]['hasAlchocol'][0]);
            }
            await SharedPrefUtil()
                .setString(SharedPrefUtil().id, order.orderList[0].id);
          }
          return OrderHistoryListModel.fromJson(json.decode(response.body));
        } else {
          return basket;
        }
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic fag(String lang) async {
    try {
      print("Fag");
      final response =
          await http.get(BASE_KS_URL + "information&inf=faq" + "&lang=${lang}");
      if (response.statusCode == 200) {
        return ListInfo.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }

  dynamic delivery(String lang) async {
    try {
      print("delivery");
      final response = await http
          .get(BASE_KS_URL + "information&inf=delivery" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body) as List;
        return a;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic aboutus(String lang) async {
    try {
      print("About Us");
      final response = await http
          .get(BASE_KS_URL + "information&inf=aboutus" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body) as List;
        return a;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic contacts(String lang) async {
    try {
      print("Contacts");
      final response = await http
          .get(BASE_KS_URL + "information&inf=contacts" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic updateUser(BuildContext context, String inf, String data) async {
    try {
      print("Update User");
      var uid = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response = await http.get(BASE_KS_URL +
          "updateuser&uid=${uid}" +
          "&inf=${inf}" +
          "&data=${data}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);

       // Navigator.pop(context);
        SharedPrefUtil().setString(inf, data);
        print(response.body);
        Fluttertoast.showToast(
            msg: a['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: greenFixed,
            textColor: Colors.white,
            fontSize: 16.0);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  userinfo() async {
    try {
      print("User info");
      var uid = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response = await http.get(BASE_KS_URL + "userinfo&id=${uid}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body) as List;
        print("USER INFO");
        return a;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic add_Remove_WishList(String id) async {
    try {
      print("Add Remove wish list");
      var uid = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response =
          await http.get(BASE_KS_URL + "addtowishlist&uid=${uid}&id=${id}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic addToBasket(String id, String weight) async {
    try {
      print("Add to basket");
      var uid = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response = await http.get(
          BASE_KS_URL + "addtobasket&uid=${uid}&id=${id}&weight=${weight}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic removeFromBasket(String id) async {
    try {
      print("Remove from basket");
      var uid = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      final response =
          await http.get(BASE_KS_URL + "removefrombasket&uid=${uid}&id=${id}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic finishBasket(Checkout checkout) async {
    try {
      print("Finish basket");
      var uid = await SharedPrefUtil().getString(
        SharedPrefUtil().uid,
      );
      final response = await http.get(
        BASE_KS_URL +
            "finishbasket&uid=${uid}&id=${checkout.id}&address=${checkout.address}&delivery_place=${checkout.delivery_place}"
                "&mobile=${checkout.mobile}&dtime_selected_val=${checkout.dtime_selected_val}"
                "&username=${checkout.username}&delivery_price=${checkout.deliveryPrice}&dpayment_selected_val=${checkout.dpayment_selected_val}",
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic upload(String photo) async {
    try {
      var uid = await SharedPrefUtil().getString(SharedPrefUtil().uid);
      String url = 'http://kenddenshehere.az/api/upload.php';
      Map<String, String> headers = {"Content-type": "application/json"};
      String jsonn = '{"uid": "$uid", "photo": "$photo"}';
      final response = await http.post(url, headers: headers, body: jsonn);
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic showAllCollection() async {
    try {
      print("Show all Collection");
      final response = await http.get(BASE_KS_URL + "collection&showall=1");
      if (response.statusCode == 200) {
        return HomeList.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }

  dynamic complaints(String lang) async {
    try {
      print("Complaints");
      final response = await http
          .get(BASE_KS_URL + "information&inf=compliants" + "&lang=${lang}");
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
     // debugPrint(exception);
    }
  }

  dynamic sendSms(mobile) async {
    try {
      int min = 100000; //min and max values act as your 6 digit range
      int max = 999999;
      var randomizer = new Random();
      var rNum = min + randomizer.nextInt(max - min);
      print(rNum);
      await SharedPrefUtil()
          .setString(SharedPrefUtil().pinCode, rNum.toString());
      String messageBody = "Sizin Kod: " + rNum.toString();
      final response = await http.get(
          'http://213.172.86.6:8080/SmileWS2/webSmpp.jsp?username=2308&password=92kh26agro&numberId=1205&msisdn=994$mobile&msgBody=$messageBody&dataCoding=0');
      if (response.statusCode == 200) {
        var a = json.decode(response.body);
        return a;
      } else {
        return null;
      }
    } catch (exception) {
      //debugPrint(exception);
    }
  }
}
