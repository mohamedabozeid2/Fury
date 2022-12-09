import 'package:equatable/equatable.dart';

class MovieKeywordsDataModel extends Equatable {
  final int id;
  final String name;

  const MovieKeywordsDataModel({required this.id, required this.name});

  factory MovieKeywordsDataModel.fromJson(Map<String, dynamic> json) {
    return MovieKeywordsDataModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
      ];
}
