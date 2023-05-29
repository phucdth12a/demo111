class DataShoe {
  String name;
  int type; // 1: man, 2: women,
  double price;
  bool liked;
  double saleOff;
  String image;

  DataShoe(
    this.name,
    this.type,
    this.price,
    this.liked,
    this.saleOff,
    this.image,
  );

  String getTextType() {
    return type == 1 ? "Men's Shoes" : "Women's Shoes";
  }
}

List<DataShoe> listData = [
  DataShoe(
    "Nike Blazer Low '77 Jumbo",
    2,
    120.11,
    false,
    10,
    "assets/1.png",
  ),
  DataShoe(
    "Nike Air Force 1 '07 LV8 Next Nature",
    1,
    320.11,
    true,
    0,
    "assets/2.png",
  ),
  DataShoe(
    "Nike Blazer Low '77 Jumbo",
    2,
    120.11,
    false,
    0,
    "assets/3.png",
  ),
  DataShoe(
    "Nike Blazer Low '77 Jumbo",
    2,
    120.11,
    false,
    0,
    "assets/4.png",
  ),
  DataShoe(
    "Nike Blazer Low '77 Jumbo",
    2,
    120.11,
    false,
    0,
    "assets/5.png",
  ),
  DataShoe(
    "Nike Blazer Low '77 Jumbo",
    2,
    120.11,
    false,
    0,
    "assets/6.jpg",
  ),
  DataShoe(
    "Nike Blazer Low '77 Jumbo",
    2,
    120.11,
    false,
    0,
    "assets/1.png",
  ),
];
