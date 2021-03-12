class Restaurant {
  String code, name, cellphone, phone, address;

  Restaurant({
    this.code,
    this.name,
    this.cellphone,
    this.phone,
    this.address,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      code: json['code'],
      name: json['name'],
      cellphone: json['cellphone'],
      phone: json['phone'],
      address: json['address'],
    );
  }
}
