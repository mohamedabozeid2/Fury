class GenresModel{

  List<GenresDataModel> genres = [];

  GenresModel.fromJson(Map<String, dynamic> json){
    json['genres'].forEach((element){
      genres.add(GenresDataModel.fromJson(element));
    });
  }
}

class GenresDataModel{
    int? id;
    String? name;

    GenresDataModel.fromJson(Map<String, dynamic> json){
      id = json['id'];
      name = json['name'];
    }
}