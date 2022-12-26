import 'package:equatable/equatable.dart';

class AccountDetails extends Equatable {
  final String hash;
  final String avatarPath;
  final int id;
  final String name;
  final bool includeAdults;
  final String userName;

  const AccountDetails(
      {required this.hash,
      required this.avatarPath,
      required this.id,
      required this.name,
      required this.includeAdults,
      required this.userName});

  @override
  List<Object?> get props => [
        hash,
        avatarPath,
        id,
        name,
        includeAdults,
        userName,
      ];
}
