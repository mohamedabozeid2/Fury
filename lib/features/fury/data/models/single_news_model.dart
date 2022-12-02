class SingleNewsModel {
  final dynamic source;
  final dynamic author;
  final dynamic title;
  final dynamic description;
  final dynamic url;
  final dynamic urlToImage;
  final dynamic publishAt;
  final dynamic content;

  SingleNewsModel({
    required this.source,
    required this.author,
    required this.description,
    required this.url,
    required this.title,
    required this.content,
    required this.publishAt,
    required this.urlToImage,
  });

  factory SingleNewsModel.fromJson(Map<String, dynamic> json) {
    return SingleNewsModel(
      source: json['source']['name'],
      author: json['author'],
      description: json['description'],
      url: json['url'],
      title: json['title'],
      content: json['content'],
      publishAt: json['publishedAt'],
      urlToImage: json['urlToImage'],
    );
  }
}
