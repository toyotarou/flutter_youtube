class Category {
  Category({
    required this.category1,
    required this.category2,
    required this.bunrui,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        category1: json['category1'].toString(),
        category2: json['category2'].toString(),
        bunrui: json['bunrui'].toString(),
      );

  String category1;
  String category2;
  String bunrui;

  Map<String, dynamic> toJson() => {
        'category1': category1,
        'category2': category2,
        'bunrui': bunrui,
      };
}
