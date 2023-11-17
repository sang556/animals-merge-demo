class Animals {
  late int id;
  late String name;
  late String coins;
  late int level;
  late String produce;

  // int shopNum;

  Animals({required this.id, required this.name, required this.coins, required this.level, required this.produce});

  Animals.fromJson(Map<String, dynamic> json) {
    // print(json['id']);
    this.id = json['id'];
    name = json['animal_name'];
    coins = json['animal_coins'];
    level = json['animal_level'];
    produce = json['animal_produce'];
    // shopNum = json['shop_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['animal_name'] = this.name;
    data['animal_coins'] = this.coins;
    data['animal_level'] = this.level;
    data['animal_produce'] = this.produce;
    // data['shop_num'] = this.shopNum;
    return data;
  }
}
