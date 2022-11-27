import '../../data/models/single_news_model.dart';
import 'package:equatable/equatable.dart';

class NewsItem extends Equatable{
  final String status;
  final int totalResults;
  final List<SingleNewsModel> articles;

  const NewsItem({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  List<Object?> get props => [
    status,
    totalResults,
    articles,
  ];
}
