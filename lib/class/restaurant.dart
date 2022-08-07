class Restaurant {
  String code, name, cellphone, phone, address;

  Restaurant({
    required this.code,
    required this.name,
    required this.cellphone,
    required this.phone,
    required this.address,
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["code"] = code;
    data["name"] = name;
    data["cellphone"] = cellphone;
    data["phone"] = phone;
    data["address"] = address;
    return data;
  }

  @override
  String toString() {
    return 'Restaurant: {\n'
        'code: $code,\n'
        'name: $name,\n'
        'phone: $phone,\n'
        'cellphone: $cellphone,\n'
        'address: $address,\n'
        '}';
  }
}
