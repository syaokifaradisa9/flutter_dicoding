import 'package:hive/hive.dart';
import 'package:submission/models/product.dart';
import 'package:submission/shared/shared.dart';
part 'detail_transaction.g.dart';

@HiveType(typeId: detailTransactionHiveIndex)
class DetailTransaction{
  @HiveField(0)
  final Product product;
  @HiveField(1)
  int amount;

  DetailTransaction({
    required this.product,
    this.amount = 1
  });

  void increaseAmount(){
    amount++;
  }

  void decreaseAmount(){
    amount--;
  }
}