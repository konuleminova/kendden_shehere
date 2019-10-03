import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter/material.dart';
import 'package:kendden_shehere/redux/common/model/place_model.dart';
import 'package:kendden_shehere/ui/page/map/flutter_map.dart';
import 'package:kendden_shehere/util/sharedpref_util.dart';

const kGoogleApiKey = "AIzaSyC1XWcwMQ-WDLXUWZOTwQW7325Wb-OeysU";
// "AIzaSyBbSJwbLSidCTD5AAn_QuAwuF5Du5ANAvg";

// to get places detail (lat/lng)
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "en",
          components: [Component(Component.country, "az")],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

Future<Null> displayPrediction(
    Prediction p, ScaffoldState scaffold, BuildContext context) async {
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  if (p != null) {
    // get detail (lat/lng)
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    print(detail.status);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    scaffold.showSnackBar(
      SnackBar(content: Text("${p.description} - $lat/$lng")),
    );
    PlaceModel placeModel = new PlaceModel();
    placeModel.longitude = lng;
    placeModel.latitude = lat;
    placeModel.countryName = p.description;
    placeModel.addressLine = p.placeId.toLowerCase();
    SharedPrefUtil sharedPrefUtil = new SharedPrefUtil();
    if (p != null) {
      await sharedPrefUtil.setString(SharedPrefUtil.address, p.description);
    }
    await sharedPrefUtil.setString(
        SharedPrefUtil.lat,lat.toString());
    await sharedPrefUtil.setString(
        SharedPrefUtil.lng,lng.toString());
    Navigator.pop(context);

//    Route route = MaterialPageRoute(
//        builder: (context) => MapPage1(placeModel: placeModel));
//    Navigator.pushReplacement(context,route);
  }
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: AppBarPlacesAutoCompleteTextField(),
      backgroundColor: Colors.lightGreen,

    );
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState, context);
        //print(p.description);
      },
       logo: Row(
        children: [Container()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),

    );
    return Scaffold(key: searchScaffoldKey, appBar: appBar, body: body);
  }

  @override
  void onResponseError(PlacesAutocompleteResponse response) {
    super.onResponseError(response);
    searchScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  void onResponse(PlacesAutocompleteResponse response) {
    super.onResponse(response);
    if (response != null && response.predictions.isNotEmpty) {
      searchScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text("Got answer")),
      );
    }
  }
}

class Uuid {
  final Random _random = Random();

  String generateV4() {
    // Generate xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx / 8-4-4-4-12.
    final int special = 8 + _random.nextInt(4);

    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }

  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);

  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);

  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
