part of 'services.dart';

class TransactionService{
  static Future<bool> saveTransaction(List<DetailTransaction> transactionsOrder) async{
    try{
      List<trans_model.Transaction> transactions = await getTransaction();

      List<DetailTransaction> dataTransaction = List<DetailTransaction>.from(transactionsOrder);

      transactions.add(trans_model.Transaction(
        id: transactions.length,
        date: DateTime.now().toString(),
        products: dataTransaction
      ));

      await saveTransactionToLocal(transactions);
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<List<trans_model.Transaction>> getTransaction() async{
    try{
      var box = await Hive.openBox(transactionBoxKey);
      if(box.containsKey(transactionLocalKey)){
        List<trans_model.Transaction> transactions = List<trans_model.Transaction>.from(box.get(transactionLocalKey));
        return transactions;
      }else{
        return [];
      }
    }catch(e){
      return [];
    }
  }

  static Future<List<DetailTransaction>> getDetailTransactionById(int id) async{
    try{
      List<trans_model.Transaction> transactions = await getTransaction();

      List<DetailTransaction> detailTransaction = [];
      for(int i=0; i<transactions.length; i++){
        if(transactions[i].id == id){
          detailTransaction = transactions[i].products;
          break;
        }
      }

      return detailTransaction;
    }catch(e){
      return [];
    }
  }
  
  static Future<void> saveTransactionToLocal(List<trans_model.Transaction> transactionsOrder) async{
    var box = await Hive.openBox(transactionBoxKey);
    box.put(transactionLocalKey, transactionsOrder);
  }

  static Future<void> deleteFromLocal() async{
    var box = await Hive.openBox(transactionBoxKey);
    box.clear();
  }
}