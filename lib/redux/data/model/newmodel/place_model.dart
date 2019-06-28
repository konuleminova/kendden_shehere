class PlaceModel {
  double latitude;
  double longitude;
  String countryName;
  String addressLine;

  PlaceModel({this.latitude, this.longitude, this.countryName, this.addressLine});

  @override
  String toString() {
    return 'PlaceModel{latitude: $latitude, longitude: $longitude, countryName: $countryName, addressLine: $addressLine}';
  }

}