class Contact {
  int? id;
  String name;
  String phone;

  Contact({this.id, required this.name, required this.phone});

  factory Contact.fromJson(var json) {
    return Contact(name: json['name'], phone: json['phone'], id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "id": id,
      "phone": phone,
    };
  }
}
