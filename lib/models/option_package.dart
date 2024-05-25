class OptionPackage {
  final String? id;
  final int? order;
  final String? name;
  final int? price;
  final List<String>? options;

  OptionPackage({
    this.id,
    this.order,
    this.name,
    this.price,
    this.options,
  });

  factory OptionPackage.fromJson(Map<String, dynamic> json) => OptionPackage(
        id: json["id"],
        order: json["order"],
        name: json["name"],
        price: json["price"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order": order,
        "name": name,
        "price": price,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
      };
}
