class SavedTownModel {
  SavedTownModel({
    required this.name,
    required this.isFavorite,
  });

  final String name;
  bool isFavorite;

  static SavedTownModel fromJson(Map<String, dynamic> json) {
    return SavedTownModel(
      name: json["name"],
      isFavorite: json["isFavorite"] == "true",
    );
  }

  String toJson() {
    return '{"name":"$name","isFavorite":"$isFavorite"}';
  }
}
