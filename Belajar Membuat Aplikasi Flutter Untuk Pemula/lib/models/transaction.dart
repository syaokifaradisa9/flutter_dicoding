import 'package:hive/hive.dart';
import 'package:submission/models/detail_transaction.dart';
import 'package:submission/shared/shared.dart';
part 'transaction.g.dart';

@HiveType(typeId: transactionHiveIndex)
class Transaction{
  @HiveField(0)
  final int id;
  @HiveField(1)
  final List<DetailTransaction> products;
  @HiveField(2)
  final String date;

  Transaction({
    required this.id,
    required this.products,
    required this.date
  });
}