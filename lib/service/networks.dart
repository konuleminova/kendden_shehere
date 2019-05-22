import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:kendden_shehere/data/model/app_state_model.dart';
import 'package:kendden_shehere/data/model/home_model.dart';
import 'package:kendden_shehere/data/model/list_categories.dart';
import 'package:kendden_shehere/redux/middleware/thunk_login.dart';

class Networks {
  static final String BASE_URL = "http://35.240.80.11/app/";
  static String LOGIN_ENDPOINT = "login/";
  static String FETCH_PRODUCT =
      "https://pulapul.com/PulaPul/?action=GetCampaignList";

//Kendden Shehere Api
  static String BASE_KS_URL = "http://kenddenshehere.az/api/?act=";
  static String LIST_CATEGORIES = BASE_KS_URL + "list_categories";

  static dynamic loginUser(String username, String password) async {
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

  static dynamic listCategories() async {
    try {
      final response = await http.get(LIST_CATEGORIES);
      if (response.statusCode == 200) {
        //print(response.body);
        return ListCategories.fromJson(json.decode(response.body));
      } else {
        return null;
      }
    } catch (exception) {}
  }
}
