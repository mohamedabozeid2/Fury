class Genres{

  List<GenresData> genres = [];

  Genres.fromJson(Map<String, dynamic> json){
    json['genres'].forEach((element){
      genres.add(GenresData.fromJson(element));
    });
  }
}

class GenresData{
  int? id;
  String? name;

  GenresData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}