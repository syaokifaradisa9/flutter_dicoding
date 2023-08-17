import 'package:hive/hive.dart';
import 'package:submission/shared/shared.dart';
part 'user_model.g.dart';

@HiveType(typeId: userHiveIndex)
class UserModel{
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String name;

  UserModel({
    required this.uid,
    required this.name,
    required this.email
  });
}