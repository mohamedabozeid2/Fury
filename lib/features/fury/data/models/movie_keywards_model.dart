class MovieKeywordsModel{
  int? id;
  List<KeywordsData> keywords = [];

  MovieKeywordsModel({required this.id, required this.keywords});

  MovieKeywordsModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    json['keywords'].forEach((element){
      keywords.add(KeywordsData.fromJson(element));
    });
  }
}


class KeywordsData{
  int? id;
  String? name;

  KeywordsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
  }
}