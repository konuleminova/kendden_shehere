import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:kendden_shehere/data/model/newmodel/place_model.dart';
import 'package:kendden_shehere/ui/page/map/map_view.dart';
import 'dart:math';

import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "AIzaSyC1XWcwMQ-WDLXUWZOTwQW7325Wb-OeysU";
// "AIzaSyBbSJwbLSidCTD5AAn_QuAwuF5Du5ANAvg";

// to get places detail (lat/lng)
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class MapPage1 extends PlacesAutocompleteWidget {
  // MapPage1({this.placeModel});
  MapPage1()
      : super(
          apiKey: kGoogleApiKey,
          sessionToken: Uuid().generateV4(),
          language: "az",
          components: [Component(Component.country, "az")],
        );

  @override
  _MapPage1State createState() => _MapPage1State();
}

class _MapPage1State extends PlacesAutocompleteState {
  static const LatLng _bakuLatLng = const LatLng(40.3716222, 49.8555191);
  GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  TextEditingController _textEditingController = new TextEditingController();
  LatLng _lastMapPositon;

  @override
  void initState() {
    super.initState();
    _lastMapPositon = _bakuLatLng;
    //  placeModel = widget.placeModel;
    //print(placeModel.toString());
  }

  Future<Null> displayPrediction(
      Prediction p, ScaffoldState scaffold, BuildContext context) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      print(detail.status);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

//      scaffold.showSnackBar(
//        SnackBar(content: Text("${p.description} - $lat/$lng")),
//      );

      setState(() {
        _lastMapPositon = new LatLng(lat, lng);
        _markers.clear();
        _markers.add(Marker(
            draggable: true,
            markerId: MarkerId(_lastMapPositon.toString()),
            position: _lastMapPositon,
            infoWindow: InfoWindow(
                title: p.description, snippet: p.placeId.toLowerCase()),
            icon: BitmapDescriptor.defaultMarker));
        if (_mapController != null) {
          _mapController.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(target: _lastMapPositon, zoom: 12.00)));
        }
      });

//    Route route = MaterialPageRoute(
//        builder: (context) => MapPage1(placeModel: placeModel));
//    Navigator.pushReplacement(context,route);

    }
  }

  @override
  Widget build(BuildContext context) {
    final body = PlacesAutocompleteResult(
      onTap: (p) {
        displayPrediction(p, searchScaffoldKey.currentState, context);
        print(p.description);
      },
      /* logo: Row(
        children: [FlutterLogo()],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      */
    );
    // TODO: implement build
    return new ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          child: AppBarPlacesAutoCompleteTextField(),
          margin: EdgeInsets.only(left: 8, right: 8),
          decoration: BoxDecoration(
              border: new Border.all(color: Colors.grey[300]),
              color: Colors.white),
        ),
        Container(
          child: body,

          //  width: MediaQuery.of(context).size.width,
          // height: body != null ? 100.0 : 0.0,
        ),
        GestureDetector(
            child: new Container(
              padding: EdgeInsets.all(1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.35,
              alignment: AlignmentDirectional.topCenter,
              color: Colors.white,
              child:  GoogleMap(
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer()))
                  ..add(Factory<VerticalDragGestureRecognizer>(
                          () => VerticalDragGestureRecognizer())),
                onTap: (LatLng location) {
                  MapDemoPage mp = new MapDemoPage();
                  mp.showMap();
                },
                polygons: setPolygon(),
                tiltGesturesEnabled: true,
                markers: _markers,
                onCameraMove: _onCameraMove,
                onMapCreated: _onMapCreated,
                initialCameraPosition:
                CameraPosition(target: _lastMapPositon, zoom: 11.00),
              ),
              margin: EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 5),
            ),
            onTap: () {
              MapDemoPage mp = new MapDemoPage();
              mp.showMap();
            }),
      ],
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  setPolygon() {
    List<LatLng> points = new List<LatLng>();
    points.add(new LatLng(40.3716222, 49.8555191));
    points.add(new LatLng(40.3716876, 49.8568066));
    points.add(new LatLng(40.3715487, 49.8570962));
    points.add(new LatLng(40.37114, 49.8573752));
    points.add(new LatLng(40.3705841, 49.8593278));
    points.add(new LatLng(40.3706822, 49.8598536));
    points.add(new LatLng(40.3703307, 49.8597248));
    points.add(new LatLng(40.3697095, 49.8619457));
    points.add(new LatLng(40.3726113, 49.8633726));
    points.add(new LatLng(40.3728565, 49.8640056));
    points.add(new LatLng(40.3728319, 49.8643489));
    points.add(new LatLng(40.3725459, 49.8645313));
    points.add(new LatLng(40.3716794, 49.8646172));
    points.add(new LatLng(40.3714996, 49.8654218));
    points.add(new LatLng(40.3716304, 49.8659475));
    points.add(new LatLng(40.3724713, 49.8659568));
    points.add(new LatLng(40.3734358, 49.8673086));
    points.add(new LatLng(40.3736156, 49.8713856));
    points.add(new LatLng(40.3746291, 49.8717075));
    points.add(new LatLng(40.3747599, 49.8793893));
    points.add(new LatLng(40.3739262, 49.8797755));
    points.add(new LatLng(40.3743022, 49.884625));
    points.add(new LatLng(40.3789773, 49.8814064));
    points.add(new LatLng(40.3843549, 49.8799043));
    points.add(new LatLng(40.3857114, 49.8798184));
    points.add(new LatLng(40.3871497, 49.8796495));
    points.add(new LatLng(40.3886207, 49.8795181));
    points.add(new LatLng(40.3889394, 49.8765355));
    points.add(new LatLng(40.3890619, 49.873467));
    points.add(new LatLng(40.3889252, 49.8692097));
    points.add(new LatLng(40.3890824, 49.8677312));
    points.add(new LatLng(40.3893602, 49.8672269));
    points.add(new LatLng(40.3896381, 49.8669748));
    points.add(new LatLng(40.3905125, 49.8668272));
    points.add(new LatLng(40.3909578, 49.8666784));
    points.add(new LatLng(40.3913542, 49.8663793));
    points.add(new LatLng(40.395158, 49.8608695));
    points.add(new LatLng(40.395784, 49.8601844));
    points.add(new LatLng(40.3969819, 49.8597782));
    points.add(new LatLng(40.4017475, 49.8579142));
    points.add(new LatLng(40.4041168, 49.8570559));
    points.add(new LatLng(40.4057263, 49.8564176));
    points.add(new LatLng(40.4044151, 49.8504175));
    points.add(new LatLng(40.4077768, 49.8489664));
    points.add(new LatLng(40.4061466, 49.8419916));
    points.add(new LatLng(40.4011973, 49.8438046));
    points.add(new LatLng(40.3998102, 49.8381073));
    points.add(new LatLng(40.3879051, 49.8307907));
    points.add(new LatLng(40.3870395, 49.8274014));
    points.add(new LatLng(40.3862378, 49.8245361));
    points.add(new LatLng(40.3829855, 49.8227876));
    points.add(new LatLng(40.3821034, 49.823067));
    points.add(new LatLng(40.3755725, 49.8241511));
    points.add(new LatLng(40.3681916, 49.8246767));
    points.add(new LatLng(40.3655927, 49.825556));
    points.add(new LatLng(40.365285, 49.8259239));
    points.add(new LatLng(40.3637677, 49.8262485));
    points.add(new LatLng(40.3647548, 49.8272409));
    points.add(new LatLng(40.364669, 49.8288394));
    points.add(new LatLng(40.3639741, 49.8308776));
    points.add(new LatLng(40.3623392, 49.8356412));
    points.add(new LatLng(40.3625239, 49.837428));
    points.add(new LatLng(40.3635376, 49.8380502));
    points.add(new LatLng(40.3646576, 49.8391231));
    points.add(new LatLng(40.3657121, 49.8403247));
    points.add(new LatLng(40.3674614, 49.8429426));
    points.add(new LatLng(40.3694662, 49.8486281));
    points.add(new LatLng(40.3693354, 49.8492075));
    points.add(new LatLng(40.3694171, 49.8498512));
    points.add(new LatLng(40.3703326, 49.8524905));
    points.add(new LatLng(40.370725, 49.8531342));
    points.add(new LatLng(40.3706105, 49.8537136));
    points.add(new LatLng(40.3707577, 49.8547221));
    points.add(new LatLng(40.371101, 49.8550869));
    points.add(new LatLng(40.3715097, 49.8551513));
    points.add(new LatLng(40.3716222, 49.8555191));

    //
    List<LatLng> points2 = new List<LatLng>();
    points2.add(new LatLng(40.3385315, 49.8338732));
    points2.add(new LatLng(40.3380542, 49.834199));
    points2.add(new LatLng(40.3382571, 49.8347267));
    points2.add(new LatLng(40.3381623, 49.8373938));
    points2.add(new LatLng(40.338967, 49.8376363));
    points2.add(new LatLng(40.33892, 49.8381808));
    points2.add(new LatLng(40.3388751, 49.8388406));
    points2.add(new LatLng(40.3389159, 49.8394093));
    points2.add(new LatLng(40.3383844, 49.8409006));
    points2.add(new LatLng(40.3384743, 49.8415336));
    points2.add(new LatLng(40.3392871, 49.842566));
    points2.add(new LatLng(40.3401351, 49.8428033));
    points2.add(new LatLng(40.3406559, 49.8426114));
    points2.add(new LatLng(40.3430009, 49.846565));
    points2.add(new LatLng(40.3421629, 49.8472193));
    points2.add(new LatLng(40.3448364, 49.8606309));
    points2.add(new LatLng(40.3460335, 49.8610613));
    points2.add(new LatLng(40.3458731, 49.8572432));
    points2.add(new LatLng(40.3451273, 49.8553146));
    points2.add(new LatLng(40.3450092, 49.8533028));
    points2.add(new LatLng(40.3452635, 49.8521117));
    points2.add(new LatLng(40.3456412, 49.8476264));
    points2.add(new LatLng(40.3472797, 49.8467239));
    points2.add(new LatLng(40.347711, 49.8466783));
    points2.add(new LatLng(40.3480502, 49.8458145));
    points2.add(new LatLng(40.3471913, 49.8430142));
    points2.add(new LatLng(40.347266, 49.8405186));
    points2.add(new LatLng(40.3485673, 49.8387741));
    points2.add(new LatLng(40.3498287, 49.8377311));
    points2.add(new LatLng(40.3511742, 49.8370612));
    points2.add(new LatLng(40.3526879, 49.836966));
    points2.add(new LatLng(40.3538509, 49.8372905));
    points2.add(new LatLng(40.3541494, 49.8359224));
    points2.add(new LatLng(40.3546409, 49.8360458));
    points2.add(new LatLng(40.3543557, 49.8377678));
    points2.add(new LatLng(40.3549792, 49.837918));
    points2.add(new LatLng(40.355294, 49.8359975));
    points2.add(new LatLng(40.3575117, 49.8364803));
    points2.add(new LatLng(40.3573175, 49.8381647));
    points2.add(new LatLng(40.3588586, 49.8386154));
    points2.add(new LatLng(40.3592225, 49.8370704));
    points2.add(new LatLng(40.3608862, 49.8371776));
    points2.add(new LatLng(40.3616233, 49.8372545));
    points2.add(new LatLng(40.3625239, 49.837428));
    points2.add(new LatLng(40.3623392, 49.8356412));
    points2.add(new LatLng(40.364669, 49.8288394));
    points2.add(new LatLng(40.3647548, 49.8272409));
    points2.add(new LatLng(40.3637677, 49.8262485));
    points2.add(new LatLng(40.365285, 49.8259239));
    points2.add(new LatLng(40.3655927, 49.825556));
    points2.add(new LatLng(40.3681916, 49.8246767));
    points2.add(new LatLng(40.3755725, 49.8241511));
    points2.add(new LatLng(40.3821034, 49.823067));
    points2.add(new LatLng(40.3829855, 49.8227876));
    points2.add(new LatLng(40.3862378, 49.8245361));
    points2.add(new LatLng(40.3879051, 49.8307907));
    points2.add(new LatLng(40.3998102, 49.8381073));
    points2.add(new LatLng(40.4011973, 49.8438046));
    points2.add(new LatLng(40.4061466, 49.8419916));
    points2.add(new LatLng(40.4077768, 49.8489664));
    points2.add(new LatLng(40.4044151, 49.8504175));
    points2.add(new LatLng(40.4057263, 49.8564176));
    points2.add(new LatLng(40.4043292, 49.857013));
    points2.add(new LatLng(40.3956746, 49.8603361));
    points2.add(new LatLng(40.395158, 49.8608695));
    points2.add(new LatLng(40.3913542, 49.8663793));
    points2.add(new LatLng(40.3909578, 49.8666784));
    points2.add(new LatLng(40.3905125, 49.8668272));
    points2.add(new LatLng(40.3896381, 49.8669748));
    points2.add(new LatLng(40.3893602, 49.8672269));
    points2.add(new LatLng(40.3890824, 49.8677312));
    points2.add(new LatLng(40.3889252, 49.8692097));
    points2.add(new LatLng(40.3890619, 49.873467));
    points2.add(new LatLng(40.3889394, 49.8765355));
    points2.add(new LatLng(40.3886207, 49.8795181));
    points2.add(new LatLng(40.3843549, 49.8799043));
    points2.add(new LatLng(40.3789773, 49.8814064));
    points2.add(new LatLng(40.3743022, 49.884625));
    points2.add(new LatLng(40.3723829, 49.885897));
    points2.add(new LatLng(40.3722897, 49.8866401));
    points2.add(new LatLng(40.373044, 49.8875696));
    points2.add(new LatLng(40.3734048, 49.8892575));
    points2.add(new LatLng(40.3743208, 49.8914318));
    points2.add(new LatLng(40.3739614, 49.8961811));
    points2.add(new LatLng(40.3806301, 49.8973504));
    points2.add(new LatLng(40.3844219, 49.8962022));
    points2.add(new LatLng(40.3896522, 49.8955692));
    points2.add(new LatLng(40.3904373, 49.90176));
    points2.add(new LatLng(40.3957648, 49.8998941));
    points2.add(new LatLng(40.4051446, 49.8855809));
    points2.add(new LatLng(40.4109936, 49.8805603));
    points2.add(new LatLng(40.4155684, 49.8749809));
    points2.add(new LatLng(40.421515, 49.8700242));
    points2.add(new LatLng(40.4195219, 49.8656682));
    points2.add(new LatLng(40.4218089, 49.853652));
    points2.add(new LatLng(40.4195636, 49.8484692));
    points2.add(new LatLng(40.4170072, 49.8361845));
    points2.add(new LatLng(40.4107989, 49.8344678));
    points2.add(new LatLng(40.408347, 49.824727));
    points2.add(new LatLng(40.3995235, 49.8158006));
    points2.add(new LatLng(40.3927907, 49.809492));
    points2.add(new LatLng(40.3903719, 49.8071746));
    points2.add(new LatLng(40.3819383, 49.8084192));
    points2.add(new LatLng(40.3655257, 49.8103933));
    points2.add(new LatLng(40.3551268, 49.8104791));
    points2.add(new LatLng(40.3534754, 49.8108869));
    points2.add(new LatLng(40.3522081, 49.8111981));
    points2.add(new LatLng(40.352396, 49.8143201));
    points2.add(new LatLng(40.3527157, 49.8152763));
    points2.add(new LatLng(40.3523814, 49.8162326));
    points2.add(new LatLng(40.3526802, 49.8168878));
    points2.add(new LatLng(40.3523718, 49.8180522));
    points2.add(new LatLng(40.3515144, 49.8176474));
    points2.add(new LatLng(40.3512983, 49.8195692));
    points2.add(new LatLng(40.3513438, 49.821019));
    points2.add(new LatLng(40.3503998, 49.8242812));
    points2.add(new LatLng(40.349652, 49.8256551));
    points2.add(new LatLng(40.3473169, 49.8287714));
    points2.add(new LatLng(40.3454104, 49.8306053));
    points2.add(new LatLng(40.3426277, 49.8348523));
    points2.add(new LatLng(40.3420666, 49.83723));
    points2.add(new LatLng(40.3385315, 49.8338732));

    ///
    List<LatLng> points3 = new List<LatLng>();
    points3.add(new LatLng(40.3739614, 49.8961811));
    points3.add(new LatLng(40.3647513, 49.9293135));
    points3.add(new LatLng(40.3562141, 49.945106));
    points3.add(new LatLng(40.356915, 49.9499148));
    points3.add(new LatLng(40.3522948, 49.9586715));
    points3.add(new LatLng(40.3481526, 49.96185));
    points3.add(new LatLng(40.348196, 49.9669364));
    points3.add(new LatLng(40.3499838, 49.9686215));
    points3.add(new LatLng(40.3546061, 49.9680909));
    points3.add(new LatLng(40.3596208, 49.9668734));
    points3.add(new LatLng(40.3599923, 49.9651359));
    points3.add(new LatLng(40.3695976, 49.9634925));
    points3.add(new LatLng(40.3724057, 49.9645579));
    points3.add(new LatLng(40.3827028, 49.9651339));
    points3.add(new LatLng(40.3837324, 49.9696261));
    points3.add(new LatLng(40.3860454, 49.9710998));
    points3.add(new LatLng(40.3851752, 49.9745846));
    points3.add(new LatLng(40.3934548, 49.9758338));
    points3.add(new LatLng(40.3930322, 49.972493));
    points3.add(new LatLng(40.4035404, 49.9723672));
    points3.add(new LatLng(40.4185973, 49.9632041));
    points3.add(new LatLng(40.4276345, 49.9392699));
    points3.add(new LatLng(40.4256118, 49.9169554));
    points3.add(new LatLng(40.4350824, 49.8874282));
    points3.add(new LatLng(40.439786, 49.8644255));
    points3.add(new LatLng(40.4404392, 49.8381614));
    points3.add(new LatLng(40.4288105, 49.8117255));
    points3.add(new LatLng(40.4137817, 49.794731));
    points3.add(new LatLng(40.3953505, 49.7866629));
    points3.add(new LatLng(40.3901528, 49.7856331));
    points3.add(new LatLng(40.3844321, 49.7870066));
    points3.add(new LatLng(40.37116, 49.7906112));
    points3.add(new LatLng(40.3657321, 49.7941305));
    points3.add(new LatLng(40.3599118, 49.7959327));
    points3.add(new LatLng(40.3536191, 49.7965548));
    points3.add(new LatLng(40.3485692, 49.7957177));
    points3.add(new LatLng(40.3452067, 49.793014));
    points3.add(new LatLng(40.3360477, 49.8082489));
    points3.add(new LatLng(40.3325801, 49.8106521));
    points3.add(new LatLng(40.3235178, 49.8164891));
    points3.add(new LatLng(40.3220125, 49.8212093));
    points3.add(new LatLng(40.3207365, 49.8280329));
    points3.add(new LatLng(40.3187077, 49.8384184));
    points3.add(new LatLng(40.3368655, 49.8448986));
    points3.add(new LatLng(40.3381623, 49.8373938));
    points3.add(new LatLng(40.3382571, 49.8347267));
    points3.add(new LatLng(40.3380542, 49.834199));
    points3.add(new LatLng(40.3385315, 49.8338732));
    points3.add(new LatLng(40.3420666, 49.83723));
    points3.add(new LatLng(40.3426277, 49.8348523));
    points3.add(new LatLng(40.3454104, 49.8306053));
    points3.add(new LatLng(40.3473169, 49.8287714));
    points3.add(new LatLng(40.3503998, 49.8242812));
    points3.add(new LatLng(40.3513438, 49.821019));
    points3.add(new LatLng(40.3512983, 49.8195692));
    points3.add(new LatLng(40.3515144, 49.8176474));
    points3.add(new LatLng(40.3523718, 49.8180522));
    points3.add(new LatLng(40.3526802, 49.8168878));
    points3.add(new LatLng(40.3523814, 49.8162326));
    points3.add(new LatLng(40.3527157, 49.8152763));
    points3.add(new LatLng(40.352396, 49.8143201));
    points3.add(new LatLng(40.3522081, 49.8111981));
    points3.add(new LatLng(40.3551268, 49.8104791));
    points3.add(new LatLng(40.3655257, 49.8103933));
    points3.add(new LatLng(40.3819383, 49.8084192));
    points3.add(new LatLng(40.3903719, 49.8071746));
    points3.add(new LatLng(40.408347, 49.824727));
    points3.add(new LatLng(40.4107989, 49.8344678));
    points3.add(new LatLng(40.4170072, 49.8361845));
    points3.add(new LatLng(40.4195636, 49.8484692));
    points3.add(new LatLng(40.4218089, 49.853652));
    points3.add(new LatLng(40.4195219, 49.8656682));
    points3.add(new LatLng(40.421515, 49.8700242));
    points3.add(new LatLng(40.4155684, 49.8749809));
    points3.add(new LatLng(40.4112123, 49.8804325));
    points3.add(new LatLng(40.4051446, 49.8855809));
    points3.add(new LatLng(40.3957648, 49.8998941));
    points3.add(new LatLng(40.3904373, 49.90176));
    points3.add(new LatLng(40.3896522, 49.8955692));
    points3.add(new LatLng(40.3806301, 49.8973504));
    points3.add(new LatLng(40.3739614, 49.8961811));

    List<Polygon> _lines = <Polygon>[
      new Polygon(
          polygonId: new PolygonId("111"),
          points: points,
          fillColor: const Color(0xFFFAAEB0),
          strokeColor: Colors.red[700],
          zIndex: 2),
    ];
    List<Polygon> _lines2 = <Polygon>[
      new Polygon(
          geodesic: true,
          polygonId: new PolygonId("112"),
          points: points2,
          strokeColor: Colors.lightGreenAccent[700],
          fillColor: const Color(0xFFB1FF50),
          //  width: 10,
          zIndex: 1),
    ];
    List<Polygon> _lines3 = <Polygon>[
      new Polygon(
          polygonId: new PolygonId("113"),
          points: points3,
          fillColor: const Color(0xFF2494F0),
          strokeColor: Colors.lightBlueAccent[700],
          //width: 10,
          zIndex: 0),
    ];
    Set<Polygon> plo = new Set();
    plo.addAll(_lines);
    plo.addAll(_lines2);
    plo.addAll(_lines3);
    return plo;
  }

  void _onCameraMove(CameraPosition position) {}
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
