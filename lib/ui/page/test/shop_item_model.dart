class ShopItem {
  int id;
  String title;
  String subtitle;
  String price;
  String image;
  bool isLiked;
  String url;
  bool status;
  int amount;

  ShopItem(
      {this.id,
      this.title,
      this.subtitle,
      this.price,
      this.image,
      this.isLiked,
      this.url,
      this.status,
      this.amount});

  bool operator == (item) => item is ShopItem && item.id == this.id && item.title == this.title;
  @override
  int get hashCode => this.id.hashCode ^ this.title.hashCode;
}
