class Category {
  String id;
  String parent;
  String name_az;
  String name_en;
  String name_ru;

  Category({this.id, this.parent, this.name_az, this.name_en, this.name_ru});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      parent: json["parent"],
      name_az: json["name_az"],
      name_en: json["name_en"],
      name_ru: json["name_ru"],
    );
  }

  @override
  String toString() {
    return 'Category{id: $id, parent: $parent, name_az: $name_az, name_en: $name_en, name_ru: $name_ru}';
  }

}
