import 'package:ditonton/domain/entities/creator.dart';
import 'package:equatable/equatable.dart';

class CreatorModel extends Equatable{
  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String profilePath;

  const CreatorModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json){
    return CreatorModel(
      id: json['id'],
      creditId: json['credit_id'],
      name: json['name'],
      gender: json['gender'] ?? 0,
      profilePath: json['profile_path'] ?? ''
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'credit_id': creditId,
      'name': name,
      'gender': gender,
      'profile_path': profilePath,
    };
  }

  Creator toEntity(){
    return Creator(
      id: id,
      creditId: creditId,
      name: name,
      gender: gender,
      profilePath: profilePath
    );
  }

  @override
  List<Object?> get props => [
    id,
    creditId,
    name,
    gender,
    profilePath,
  ];
}