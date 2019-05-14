import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';

class FlutterPlacesApi extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new FlutterPlacesState();
  }
}

class FlutterPlacesState extends State<FlutterPlacesApi> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new AppBar();
  }

  @override
  void initState() {
    super.initState();
    mainGet();
  }

  final places = GoogleMapsPlaces(
      apiKey: Platform.environment['AIzaSyCJfo0nfcJzO-MJTRm3G6hlpW6MD2uKKbQ']);

  Future<void> mainGet() async {
    String sessionToken = 'xyzabc_1234';
    PlacesAutocompleteResponse res =
        await places.autocomplete('Baku', sessionToken: sessionToken);
    print(res.status);

    if (res.isOkay) {
      // list autocomplete prediction
      for (var p in res.predictions) {
        print('- ${p.description}');
      }
    }
  }
}
