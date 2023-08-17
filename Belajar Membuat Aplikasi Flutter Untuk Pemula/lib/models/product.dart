import 'package:hive/hive.dart';
import 'package:submission/shared/shared.dart';
part 'product.g.dart';

@HiveType(typeId: productHiveIndex)
class Product{
  @HiveField(0)
  int? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int price;
  @HiveField(3)
  String? photoUrl;
  @HiveField(4)
  String category;

  Product({
    this.id,
    required this.name,
    required this.price,
    this.photoUrl,
    required this.category
  });

  Map<String,dynamic> toJson(){
    return {
      "id" : id,
      "name" : name,
      "price" : price,
      "category" : category,
      "photoUrl" : photoUrl
    };
  }
}