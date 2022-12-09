import 'package:equatable/equatable.dart';

class GenresData extends Equatable {
  final int id;
  final String name;

  const GenresData({
    required this.id,
    required this.name,
  });

  factory GenresData.fromJson(Map<String, dynamic> json) {
    return GenresData(id: json['id'], name: json['name']);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
      ];
}
