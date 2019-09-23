class Info {
  String q;
  String a;

  Info({this.q, this.a});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(q: json['q'], a: json['a']);
  }
}
