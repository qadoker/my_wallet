
class CategoryField{
  static const id = 'id';
}

class Category {
  String id;
  String name;
  int iconValue;

  Category({this.id, this.name, this.iconValue});

  static Category fromJson(Map<String, dynamic> json) => Category(
      id: json['id'],
      name: json['name'],
      iconValue: json['iconValue']
  );

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'iconValue': iconValue
      };
}
