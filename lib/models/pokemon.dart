class Pokemon {
  int id;
  String name;
  String height;
  String weight;
  String imageUrl;
  String types;
  String hp;
  String attack;

  Pokemon({required this.id, required this.name, required this.height, required this.weight, required this.imageUrl, required this.types, required this.hp, required this.attack});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      imageUrl: json['sprites']['front_default'],
      types: json['types'][0]['type']['name'],
      hp: json['stats'][5]['base_stat'].toString(),
      attack: json['stats'][4]['base_stat'].toString(),
    );
  }
}