class ErrorModel {
  String error;
  String error_field;

  ErrorModel({this.error, this.error_field});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(error: json["error"], error_field: json["error_field"]);
  }

  @override
  String toString() {
    return 'ErrorModel{error: $error, error_field: $error_field}';
  }

}
