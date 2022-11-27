class SingleNewsModel {
  final dynamic author;
  final String title;
  final String description;
  final String url;
  final dynamic urlToImage;
  final String publishAt;
  final String content;

  SingleNewsModel({
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
