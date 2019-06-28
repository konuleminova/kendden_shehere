class NewProduct {
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

  NewProduct(
      {this.id,
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
      this.hasphoto});

  factory NewProduct.fromJson(Map<String, dynamic> json) {
    return NewProduct(
        id: json["id"],
        name_en: json["name_en"] ?? "Sample Title",
        name_az: json["name_az"] ?? "Sample Title",
        name_ru: json["name_ru"] ?? "Sample Title",
        img: json["img"] ?? "https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg",
        maininfo_az: json["maininfo_az"] ?? "Description",
        maininfo_en: json["maininfo_en"] ?? "Description",
        maininfo_ru: json["maininfo_ru"] ?? "Description",
        count: json["count"] ?? "1",
        counttype: json["counttype"] ?? "eded",
        hasphoto: json["hasphoto"] ?? "0",
        price: json["price"] ?? "AZN");
  }

  @override
  String toString() {
    return 'NewProduct{id: $id, name_az: $name_az, name_ru: $name_ru, name_en: $name_en, maininfo_az: $maininfo_az, maininfo_en: $maininfo_en, maininfo_ru: $maininfo_ru, count: $count, counttype: $counttype, img: $img, price: $price, hasphoto: $hasphoto}';
  }
}
