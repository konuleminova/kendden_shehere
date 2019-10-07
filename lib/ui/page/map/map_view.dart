import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';

///This API Key will be used for both the interactive maps as well as the static maps.
///Make sure that you have enabled the following APIs in the Google API Console (https://console.developers.google.com/apis)
/// - Static Maps API
/// - Android Maps API
/// - iOS Maps API
const API_KEY = "AIzaSyC5b4ygf2aPikhkstqxTgme891YjorFKg4";

class MapDemoPage {
  //
  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;

  //Marker bubble
  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Something fragile!",
      45.52480841512737,
      -122.66201455146073,
      color: Colors.blue,
      draggable: true, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
  ];

  //Line
  List<Polyline> _lines = <Polyline>[
    new Polyline(
        "11",
        <Location>[
          new Location(45.52309483308097, -122.67339684069155),
          new Location(45.52298442915803, -122.66339991241693),
        ],
        width: 15.0,
        color: const Color(0xFFF8D986)),
  ];

  //Drawing
  List<Polygon> _polygons = <Polygon>[
    new Polygon(
      "111",
      <Location>[
        new Location(40.3716222, 49.8555191),
        new Location(40.3716876, 49.8568066),
        new Location(40.3715487, 49.8570962),
        new Location(40.37114, 49.8573752),
        new Location(40.3705841, 49.8593278),
        new Location(40.3706822, 49.8598536),
        new Location(40.3703307, 49.8597248),
        new Location(40.3697095, 49.8619457),
        new Location(40.3726113, 49.8633726),
        new Location(40.3728565, 49.8640056),
        new Location(40.3728319, 49.8643489),
        new Location(40.3725459, 49.8645313),
        new Location(40.3716794, 49.8646172),
        new Location(40.3714996, 49.8654218),
        new Location(40.3716304, 49.8659475),
        new Location(40.3724713, 49.8659568),
        new Location(40.3734358, 49.8673086),
        new Location(40.3736156, 49.8713856),
        new Location(40.3746291, 49.8717075),
        new Location(40.3747599, 49.8793893),
        new Location(40.3739262, 49.8797755),
        new Location(40.3743022, 49.884625),
        new Location(40.3789773, 49.8814064),
        new Location(40.3843549, 49.8799043),
        new Location(40.3857114, 49.8798184),
        new Location(40.3871497, 49.8796495),
        new Location(40.3886207, 49.8795181),
        new Location(40.3889394, 49.8765355),
        new Location(40.3890619, 49.873467),
        new Location(40.3889252, 49.8692097),
        new Location(40.3890824, 49.8677312),
        new Location(40.3893602, 49.8672269),
        new Location(40.3896381, 49.8669748),
        new Location(40.3905125, 49.8668272),
        new Location(40.3909578, 49.8666784),
        new Location(40.3913542, 49.8663793),
        new Location(40.395158, 49.8608695),
        new Location(40.395784, 49.8601844),
        new Location(40.3969819, 49.8597782),
        new Location(40.4017475, 49.8579142),
        new Location(40.4041168, 49.8570559),
        new Location(40.4057263, 49.8564176),
        new Location(40.4044151, 49.8504175),
        new Location(40.4077768, 49.8489664),
        new Location(40.4061466, 49.8419916),
        new Location(40.4011973, 49.8438046),
        new Location(40.3998102, 49.8381073),
        new Location(40.3879051, 49.8307907),
        new Location(40.3870395, 49.8274014),
        new Location(40.3862378, 49.8245361),
        new Location(40.3829855, 49.8227876),
        new Location(40.3821034, 49.823067),
        new Location(40.3755725, 49.8241511),
        new Location(40.3681916, 49.8246767),
        new Location(40.3655927, 49.825556),
        new Location(40.365285, 49.8259239),
        new Location(40.3637677, 49.8262485),
        new Location(40.3647548, 49.8272409),
        new Location(40.364669, 49.8288394),
        new Location(40.3639741, 49.8308776),
        new Location(40.3623392, 49.8356412),
        new Location(40.3625239, 49.837428),
        new Location(40.3635376, 49.8380502),
        new Location(40.3646576, 49.8391231),
        new Location(40.3657121, 49.8403247),
        new Location(40.3674614, 49.8429426),
        new Location(40.3694662, 49.8486281),
        new Location(40.3693354, 49.8492075),
        new Location(40.3694171, 49.8498512),
        new Location(40.3703326, 49.8524905),
        new Location(40.370725, 49.8531342),
        new Location(40.3706105, 49.8537136),
        new Location(40.3707577, 49.8547221),
        new Location(40.371101, 49.8550869),
        new Location(40.3715097, 49.8551513),
        new Location(40.3716222, 49.8555191)
      ],
      jointType: FigureJointType.bevel,
      strokeWidth: 5.0,
      fillColor: const Color(0xFFFCAEAE),
      strokeColor: const Color(0xFFE2AD98),
    ),
  ];
  List<Polygon> _polygons2 = <Polygon>[
    new Polygon(
      "112",
      <Location>[
        new Location(40.3385315, 49.8338732),
        new Location(40.3380542, 49.834199),
        new Location(40.3382571, 49.8347267),
        new Location(40.3381623, 49.8373938),
        new Location(40.338967, 49.8376363),
        new Location(40.33892, 49.8381808),
        new Location(40.3388751, 49.8388406),
        new Location(40.3389159, 49.8394093),
        new Location(40.3383844, 49.8409006),
        new Location(40.3384743, 49.8415336),
        new Location(40.3392871, 49.842566),
        new Location(40.3401351, 49.8428033),
        new Location(40.3406559, 49.8426114),
        new Location(40.3430009, 49.846565),
        new Location(40.3421629, 49.8472193),
        new Location(40.3448364, 49.8606309),
        new Location(40.3460335, 49.8610613),
        new Location(40.3458731, 49.8572432),
        new Location(40.3451273, 49.8553146),
        new Location(40.3450092, 49.8533028),
        new Location(40.3452635, 49.8521117),
        new Location(40.3456412, 49.8476264),
        new Location(40.3472797, 49.8467239),
        new Location(40.347711, 49.8466783),
        new Location(40.3480502, 49.8458145),
        new Location(40.3471913, 49.8430142),
        new Location(40.347266, 49.8405186),
        new Location(40.3485673, 49.8387741),
        new Location(40.3498287, 49.8377311),
        new Location(40.3511742, 49.8370612),
        new Location(40.3526879, 49.836966),
        new Location(40.3538509, 49.8372905),
        new Location(40.3541494, 49.8359224),
        new Location(40.3546409, 49.8360458),
        new Location(40.3543557, 49.8377678),
        new Location(40.3549792, 49.837918),
        new Location(40.355294, 49.8359975),
        new Location(40.3575117, 49.8364803),
        new Location(40.3573175, 49.8381647),
        new Location(40.3588586, 49.8386154),
        new Location(40.3592225, 49.8370704),
        new Location(40.3608862, 49.8371776),
        new Location(40.3616233, 49.8372545),
        new Location(40.3625239, 49.837428),
        new Location(40.3623392, 49.8356412),
        new Location(40.364669, 49.8288394),
        new Location(40.3647548, 49.8272409),
        new Location(40.3637677, 49.8262485),
        new Location(40.365285, 49.8259239),
        new Location(40.3655927, 49.825556),
        new Location(40.3681916, 49.8246767),
        new Location(40.3755725, 49.8241511),
        new Location(40.3821034, 49.823067),
        new Location(40.3829855, 49.8227876),
        new Location(40.3862378, 49.8245361),
        new Location(40.3879051, 49.8307907),
        new Location(40.3998102, 49.8381073),
        new Location(40.4011973, 49.8438046),
        new Location(40.4061466, 49.8419916),
        new Location(40.4077768, 49.8489664),
        new Location(40.4044151, 49.8504175),
        new Location(40.4057263, 49.8564176),
        new Location(40.4043292, 49.857013),
        new Location(40.3956746, 49.8603361),
        new Location(40.395158, 49.8608695),
        new Location(40.3913542, 49.8663793),
        new Location(40.3909578, 49.8666784),
        new Location(40.3905125, 49.8668272),
        new Location(40.3896381, 49.8669748),
        new Location(40.3893602, 49.8672269),
        new Location(40.3890824, 49.8677312),
        new Location(40.3889252, 49.8692097),
        new Location(40.3890619, 49.873467),
        new Location(40.3889394, 49.8765355),
        new Location(40.3886207, 49.8795181),
        new Location(40.3843549, 49.8799043),
        new Location(40.3789773, 49.8814064),
        new Location(40.3743022, 49.884625),
        new Location(40.3723829, 49.885897),
        new Location(40.3722897, 49.8866401),
        new Location(40.373044, 49.8875696),
        new Location(40.3734048, 49.8892575),
        new Location(40.3743208, 49.8914318),
        new Location(40.3739614, 49.8961811),
        new Location(40.3806301, 49.8973504),
        new Location(40.3844219, 49.8962022),
        new Location(40.3896522, 49.8955692),
        new Location(40.3904373, 49.90176),
        new Location(40.3957648, 49.8998941),
        new Location(40.4051446, 49.8855809),
        new Location(40.4109936, 49.8805603),
        new Location(40.4155684, 49.8749809),
        new Location(40.421515, 49.8700242),
        new Location(40.4195219, 49.8656682),
        new Location(40.4218089, 49.853652),
        new Location(40.4195636, 49.8484692),
        new Location(40.4170072, 49.8361845),
        new Location(40.4107989, 49.8344678),
        new Location(40.408347, 49.824727),
        new Location(40.3995235, 49.8158006),
        new Location(40.3927907, 49.809492),
        new Location(40.3903719, 49.8071746),
        new Location(40.3819383, 49.8084192),
        new Location(40.3655257, 49.8103933),
        new Location(40.3551268, 49.8104791),
        new Location(40.3534754, 49.8108869),
        new Location(40.3522081, 49.8111981),
        new Location(40.352396, 49.8143201),
        new Location(40.3527157, 49.8152763),
        new Location(40.3523814, 49.8162326),
        new Location(40.3526802, 49.8168878),
        new Location(40.3523718, 49.8180522),
        new Location(40.3515144, 49.8176474),
        new Location(40.3512983, 49.8195692),
        new Location(40.3513438, 49.821019),
        new Location(40.3503998, 49.8242812),
        new Location(40.349652, 49.8256551),
        new Location(40.3473169, 49.8287714),
        new Location(40.3454104, 49.8306053),
        new Location(40.3426277, 49.8348523),
        new Location(40.3420666, 49.83723),
        new Location(40.3385315, 49.8338732)
      ],
      jointType: FigureJointType.bevel,
      strokeWidth: 5.0,
      strokeColor: const Color(0xFFAAD47D),
      fillColor: const Color(0xFFA3F0A3),
    ),
  ];
  List<Polygon> _polygons3 = <Polygon>[
    new Polygon(
        "114",
        <Location>[
          new Location(40.3739614, 49.8961811),
          new Location(40.3647513, 49.9293135),
          new Location(40.3562141, 49.945106),
          new Location(40.356915, 49.9499148),
          new Location(40.3522948, 49.9586715),
          new Location(40.3481526, 49.96185),
          new Location(40.348196, 49.9669364),
          new Location(40.3499838, 49.9686215),
          new Location(40.3546061, 49.9680909),
          new Location(40.3596208, 49.9668734),
          new Location(40.3599923, 49.9651359),
          new Location(40.3695976, 49.9634925),
          new Location(40.3724057, 49.9645579),
          new Location(40.3827028, 49.9651339),
          new Location(40.3837324, 49.9696261),
          new Location(40.3860454, 49.9710998),
          new Location(40.3851752, 49.9745846),
          new Location(40.3934548, 49.9758338),
          new Location(40.3930322, 49.972493),
          new Location(40.4035404, 49.9723672),
          new Location(40.4185973, 49.9632041),
          new Location(40.4276345, 49.9392699),
          new Location(40.4256118, 49.9169554),
          new Location(40.4350824, 49.8874282),
          new Location(40.439786, 49.8644255),
          new Location(40.4404392, 49.8381614),
          new Location(40.4288105, 49.8117255),
          new Location(40.4137817, 49.794731),
          new Location(40.3953505, 49.7866629),
          new Location(40.3901528, 49.7856331),
          new Location(40.3844321, 49.7870066),
          new Location(40.37116, 49.7906112),
          new Location(40.3657321, 49.7941305),
          new Location(40.3599118, 49.7959327),
          new Location(40.3536191, 49.7965548),
          new Location(40.3485692, 49.7957177),
          new Location(40.3452067, 49.793014),
          new Location(40.3360477, 49.8082489),
          new Location(40.3325801, 49.8106521),
          new Location(40.3235178, 49.8164891),
          new Location(40.3220125, 49.8212093),
          new Location(40.3207365, 49.8280329),
          new Location(40.3187077, 49.8384184),
          new Location(40.3368655, 49.8448986),
          new Location(40.3381623, 49.8373938),
          new Location(40.3382571, 49.8347267),
          new Location(40.3380542, 49.834199),
          new Location(40.3385315, 49.8338732),
          new Location(40.3420666, 49.83723),
          new Location(40.3426277, 49.8348523),
          new Location(40.3454104, 49.8306053),
          new Location(40.3473169, 49.8287714),
          new Location(40.3503998, 49.8242812),
          new Location(40.3513438, 49.821019),
          new Location(40.3512983, 49.8195692),
          new Location(40.3515144, 49.8176474),
          new Location(40.3523718, 49.8180522),
          new Location(40.3526802, 49.8168878),
          new Location(40.3523814, 49.8162326),
          new Location(40.3527157, 49.8152763),
          new Location(40.352396, 49.8143201),
          new Location(40.3522081, 49.8111981),
          new Location(40.3551268, 49.8104791),
          new Location(40.3655257, 49.8103933),
          new Location(40.3819383, 49.8084192),
          new Location(40.3903719, 49.8071746),
          new Location(40.408347, 49.824727),
          new Location(40.4107989, 49.8344678),
          new Location(40.4170072, 49.8361845),
          new Location(40.4195636, 49.8484692),
          new Location(40.4218089, 49.853652),
          new Location(40.4195219, 49.8656682),
          new Location(40.421515, 49.8700242),
          new Location(40.4155684, 49.8749809),
          new Location(40.4112123, 49.8804325),
          new Location(40.4051446, 49.8855809),
          new Location(40.3957648, 49.8998941),
          new Location(40.3904373, 49.90176),
          new Location(40.3896522, 49.8955692),
          new Location(40.3806301, 49.8973504),
          new Location(40.3739614, 49.8961811)
        ],
        jointType: FigureJointType.bevel,
        strokeWidth: 5.0,
        strokeColor: const Color(0xFFF8D986),
        fillColor: const Color(0xFFF6DD82)),
  ];

  showMap() {
    MapView.setApiKey(API_KEY);
    mapView.show(
        new MapOptions(
          mapViewType: MapViewType.normal,
          showUserLocation: true,
          showMyLocationButton: true,
          showCompassButton: true,
          initialCameraPosition:
              new CameraPosition(new Location(40.3716222, 49.8555191), 11.0),
          hideToolbar: false,
          title: "Zonalar",
        ),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      //mapView.setMarkers(_markers);
      mapView.setPolylines(_lines);
      for (int i = 0; i < _polygons2.length; i++) {
        mapView.addPolygon(_polygons2[i]);
      }
      for (int i = 0; i < _polygons.length; i++) {
        mapView.addPolygon(_polygons[i]);
      }
      for (int i = 0; i < _polygons3.length; i++) {
        mapView.addPolygon(_polygons3[i]);
      }
    });
    compositeSubscription.add(sub);
    sub = mapView.onLocationUpdated.listen((location) {
      print("Location updated $location");
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation ${annotation.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolyline
        .listen((polyline) => print("polyline ${polyline.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolygon
        .listen((polygon) => print("polygon ${polygon.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);
    //  sub = mapView.onCameraChanged.listen((cameraPosition) =>
    //  this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);
    sub = mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging started");
    });
    sub = mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging ended");
    });
    sub = mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      print(
          "Annotation ${marker.id} moved to ${location.latitude} , ${location.longitude}");
    });
    compositeSubscription.add(sub);
    sub = mapView.onToolbarAction.listen((id) {
      print("Toolbar button id = $id");
      if (id == 1) {
        mapView.dismiss();
      }
    });
    compositeSubscription.add(sub);
    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
    compositeSubscription.add(sub);
    compositeSubscription.add(sub);

    _handleDismiss() async {
      double zoomLevel = await mapView.zoomLevel;
      Location centerLocation = await mapView.centerLocation;
      List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
      List<Polyline> visibleLines = await mapView.visiblePolyLines;
      List<Polygon> visiblePolygons = await mapView.visiblePolygons;
      print("Zoom Level: $zoomLevel");
      print("Center: $centerLocation");
      print("Visible Annotation Count: ${visibleAnnotations.length}");
      print("Visible Polylines Count: ${visibleLines.length}");
      print("Visible Polygons Count: ${visiblePolygons.length}");
      var uri = await staticMapProvider.getImageUriFromMap(mapView,
          width: 900, height: 400);
      //setState(() => staticMapUri = uri);
      mapView.dismiss();
      compositeSubscription.cancel();
    }
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
/*
  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                    return AlertDialog(
                            title: new Text("Map tapped!"),
                            content: new Text("You tapped in " +
                                location.latitude.toString() +
                                ", " +
                                location.longitude.toString()),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });

 */
