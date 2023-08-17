part of 'providers.dart';

class CashierProvider with ChangeNotifier{
  List<Product> products = [];
  List<String> categories = [];
  List<Product> filteredProducts = [];
  List<DetailTransaction> orderedProduct = [];

  int currentCategoryIndex = 0;

  void reset() async{
    products = await ProductService.getFromLocal();
    categories = List<String>.from(await CategoryService.getFromLocal());
    categories.insert(0, "Semua");

    filteredProducts = products;
    orderedProduct = [];

    currentCategoryIndex = 0;

    notifyListeners();
  }

  void resetTransaction(){
    orderedProduct.clear();
    notifyListeners();
  }

  void changeProductCategory(int index){
    currentCategoryIndex = index;
    if(index == 0){
      filteredProducts = products;
    }else{
      filteredProducts = products.where((p) => p.category == categories[index]).toList();
    }
    notifyListeners();
  }

  void addOrderProduct(int productId){
    bool canAdded = true;
    for(int i = 0; i<orderedProduct.length; i++){
      if(orderedProduct[i].product.id == productId){
        orderedProduct[i].increaseAmount();
        canAdded = false;
        break;
      }
    }

    if(canAdded){
      orderedProduct.add(DetailTransaction(
        product: filteredProducts.where((element) => element.id == productId).toList()[0],
        amount: 1
      ));
    }

    notifyListeners();
  }

  void increaseAmountOrder(int index){
    orderedProduct[index].increaseAmount();
    notifyListeners();
  }

  void decreaseAmountOrder(int index){
    if(orderedProduct[index].amount != 1){
      orderedProduct[index].decreaseAmount();
    }else{
      orderedProduct.removeAt(index);
    }
    notifyListeners();
  }
}