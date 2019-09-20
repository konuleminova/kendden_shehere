import 'package:kendden_shehere/redux/productlist/new_product_model.dart';

class QSearchModel {
  String type;
  String name;
  String id;
  String name_az;
  String name_ru;
  String name_en;
  String maininfo_az;
  String maininfo_en;
  String maininfo_ru;
  String count;
  String counttype;
  String img;
  String price;
  String hasphoto;
  String code;
  String catid;
  String catIdParent;

  QSearchModel({
    this.type,
    this.name,
    this.id,
    this.name_az,
    this.name_ru,
    this.name_en,
    this.maininfo_az,
    this.maininfo_en,
    this.maininfo_ru,
    this.count,
    this.counttype,
    this.img,
    this.price,
    this.hasphoto,
    this.code,
    this.catid,
    this.catIdParent
  });

  factory QSearchModel.fromJson(json) {
    return new QSearchModel(
        type: json['type'] ?? "",
        name: json['name'] ?? "",
        catid: json['cat_id'] ?? null,
        catIdParent: json['cat-id'] ?? null,
        id: json["id"],
        name_en: json["name_en"] ??null,
        name_az: json["name_az"] ?? "Sample Title",
        name_ru: json["name_ru"] ?? "Sample Title",
        img: json["img"] ??
            "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg",
        maininfo_az: json["maininfo_az"] ?? "Description",
        maininfo_en: json["maininfo_en"] ?? "Description",
        maininfo_ru: json["maininfo_ru"] ?? "Description",
        count: json["count"] ?? "1",
        counttype: json["counttype"] ?? "eded",
        hasphoto: json["hasphoto"] ?? "0",
        price: json["price"] ?? "AZN",
        code: json["code"] ?? "");
    //  cat_id: json["cat_id"] ?? "Sample Title");
  }
}
