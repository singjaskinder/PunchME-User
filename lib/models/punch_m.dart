class PunchM {
  String oid;
  String pid;
  String image;
  String name;
  String description;
  List<double> location;
  int doIt;
  int getIt;
  int offerDo;
  int offerGet;
  double price;
  bool punch;
  String date;

  PunchM(
      {this.oid,
      this.pid,
      this.image,
      this.name,
      this.description,
      this.location,
      this.doIt,
      this.getIt,
      this.offerDo,
      this.offerGet,
      this.price,
      this.punch,
      this.date});

  PunchM.fromJson(Map<String, dynamic> json) {
    oid = json['oid'];
    pid = json['pid'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    if (json['location'] != null) location = json['location'].cast<double>();
    doIt = json['do_it'];
    getIt = json['get_it'];
    offerDo = json['offer_do'];
    offerGet = json['offer_get'];
    price = json['price'];
    punch = json['punch'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oid'] = this.oid;
    data['pid'] = this.pid;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location'] = this.location;
    data['do_it'] = this.doIt;
    data['get_it'] = this.getIt;
    data['offer_do'] = this.offerDo;
    data['offer_get'] = this.offerGet;
    data['price'] = this.price;
    data['punch'] = this.punch;
    data['date'] = this.date;
    return data;
  }
}
