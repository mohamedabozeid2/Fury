class MovieKeywords{
  int? id;
  List<KeywordsData> keywords = [];

  MovieKeywords({required this.id, required this.keywords});

  MovieKeywords.fromJson(Map<String, dynamic> json){
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