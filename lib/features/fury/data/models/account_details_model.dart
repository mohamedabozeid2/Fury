import 'package:movies_application/features/fury/domain/entities/account_details.dart';

class AccountDetailsModel extends AccountDetails {
  const AccountDetailsModel({
    required super.hash,
    required super.avatarPath,
    required super.id,
    required super.name,
    required super.includeAdults,
    required super.userName,
  });

  factory AccountDetailsModel.fromJson(Map<String, dynamic> json) {
    return AccountDetailsModel(
      hash: json['avatar']['gravatar']['hash'],
      avatarPath: json['avatar']['tmdb']['avatar_path'],
      id: json['id'],
      name: json['name'],
      includeAdults: json['include_adult'],
      userName: json['username'],
    );
  }
}
