class NewsItem {
  int? totalResults;
  List<NewsItemModel> news = [];

  NewsItem.fromJson(Map<String, dynamic> json) {
    totalResults = json['totalResults'];
    json['articles'].forEach((element) {
      news.add(NewsItemModel.fromJson(element));
    });
  }
}

class NewsItemModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? imageUrl;
  String? date;
  String? content;

  NewsItemModel.fromJson(Map<String, dynamic> json) {
    author = json['author'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    imageUrl = json['urlToImage'];
    date = json['publishedAt'];
    content = json['content'];
  }
}
