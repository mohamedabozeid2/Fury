import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'account_details.g.dart';

@HiveType(typeId: 0)
class AccountDetails extends Equatable {
  @HiveField(0)
  final String hash;
  @HiveField(1)
  final String avatarPath;
  @HiveField(2)
  final int id;
  @HiveField(3)
  final String name;
  @HiveField(4)
  final bool includeAdults;
  @HiveField(5)
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
