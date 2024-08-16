class OrodhaCategoryModel {
  final int id;
  final String name;
  final String? nameEn;
  final String alias;
  final String iconUrl;
  final int ordering;
  final int published;

  OrodhaCategoryModel({
    required this.id,
    required this.name,
    this.nameEn,
    required this.alias,
    required this.iconUrl,
    required this.ordering,
    required this.published,
  });

  factory OrodhaCategoryModel.fromJson(Map<String, dynamic> json) {
    return OrodhaCategoryModel(
      id: json['id'],
      name: json['name'],
      nameEn: json['name_en'],
      alias: json['alias'],
      iconUrl: json['icon_url'],
      ordering: json['ordering'],
      published: json['published'],
    );
  }
}
