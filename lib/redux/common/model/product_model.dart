class Product {
  int id;
  String title;
  String subtitle;
  String price;
  String image;
  bool isLiked;
  String url;
  bool isAdded;
  int amount;

  Product(
      {this.id,
      this.title,
      this.subtitle,
      this.price,
      this.image,
      this.isLiked,
      this.url,
      this.isAdded,
      this.amount});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["ID"],
        title: json["TITLE"]??"Sample Title",
        image: json["IMAGE"]??"images/img1.jpg",
        isLiked: json["LIKED"],
        url: json["URL"],
        isAdded: false,
        amount: 1,
        subtitle: "1kq",
        price: "1 AZN");
  }

  @override
  String toString() {
    return 'Data{id: $id, title: $title, image: $image, liked: $isLiked, url: $url}';
  }
}
