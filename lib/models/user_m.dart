class UserM {
  int date;
  String id;
  String image;
  String token;
  String email;
  String name;
  String phone;

  UserM(
      {this.id,
      this.token,
      this.email,
      this.image,
      this.name,
      this.phone,
      this.date});

  UserM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    image = json['image'];
    token = json['token'];
    name = json['name'];
    phone = json['phone'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['image'] = this.image;
    data['token'] = this.token;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['date'] = this.date;
    return data;
  }
}
