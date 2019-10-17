class Checkout {
  String id;
  String address;
  String delivery_place;
  String mobile;
  String dtime_selected_val;
  String username;
  String price;
  String dpayment_selected_val;
  String deliveryPrice;
  String teciliCatdirlma;

  Checkout(
      {this.id,
      this.address,
      this.delivery_place,
      this.mobile,
      this.dtime_selected_val,
      this.username,
      this.price,
      this.dpayment_selected_val,this.deliveryPrice,this.teciliCatdirlma});

  @override
  String toString() {
    return 'Checkout{id: $id, address: $address, delivery_place: $delivery_place, mobile: $mobile, dtime_selected_val: $dtime_selected_val, username: $username, delivery_price: $price, dpayment_selected_val: $dpayment_selected_val}';
  }


}
