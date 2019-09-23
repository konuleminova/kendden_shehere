class Info {
  String q;
  String a;
  //String header;
  String body;

  Info({this.q, this.a, this.body});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        q: json['q']??null, a: json['a']??null, body: json['body']);
  }
}
