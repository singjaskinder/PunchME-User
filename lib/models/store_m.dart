class StoreM {
  String id;
  int date;
  String name;
  String description;
  String timings;
  int totalOffers;
  List<String> images;
  String mapLink;
  Object location;
  String address;
  String province;
  bool status;
  bool isStore;
  String banFor;
  String email;
  String ownerName;
  String phone;

  StoreM(
      {this.id,
      this.date,
      this.name,
      this.description,
      this.timings,
      this.totalOffers,
      this.images,
      this.mapLink,
      this.location,
      this.address,
      this.province,
      this.status,
      this.isStore,
      this.banFor,
      this.email,
      this.ownerName,
      this.phone});

  StoreM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    name = json['name'];
    description = json['description'];
    timings = json['timings'];
    totalOffers = json['total_offers'];
    images = json['images'].cast<String>();
    mapLink = json['mapLink'];
    location = json['location']['geopoint'];
    address = json['address'];
    province = json['province'];
    isStore = json['is_store'];
    status = json['status'];
    banFor = json['ban_for'];
    email = json['email'];
    ownerName = json['owner_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['name'] = this.name;
    data['description'] = this.description;
    data['timings'] = this.timings;
    data['total_offers'] = this.totalOffers;
    data['images'] = this.images;
    data['mapLink'] = this.mapLink;
    data['location'] = this.location;
    data['address'] = this.address;
    data['province'] = this.province;
    data['is_store'] = this.isStore;
    data['status'] = this.status;
    data['ban_for'] = this.banFor;
    data['email'] = this.email;
    data['owner_name'] = this.ownerName;
    data['phone'] = this.phone;
    return data;
  }
}
