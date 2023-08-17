part of 'services.dart';

class CategoryService{
  static Future<List<String>> getCategory() async{
    try{
      CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();

      List data = snapshot.get("kategori") as List;
      List<String> categories = List<String>.from(data);
      return categories;
    }catch(e){
      return [];
    }
  }

  static Future<bool> addCategory(String value) async{
    List<String> categories = await getFromLocal();
    if(!categories.contains(value)){
      categories.add(value);
      await saveToLocal(categories);
      return true;
    }else{
      return false;
    }
  }

  static Future<bool> editCategory(String value, String newValue) async{
    try{
      List<String> categories = await getFromLocal();

      int editedIndex = categories.indexOf(value);
      categories[editedIndex] = newValue;

      await ProductService.changeCategoryProduct(value, newValue);
      await saveToLocal(categories);

      return true;
    }catch(e){
      return false;
    }
  }

  static Future<bool> deleteCategory(String value) async{
    try{
      List<String> categories = await getFromLocal();
      categories.removeWhere((element) => element == value);

      await ProductService.deleteProductByCategory(value);
      await saveToLocal(categories);

      return true;
    }catch(e){
      return false;
    }
  }

  static Future<void> saveToLocal(List<String> categories) async{
    final String uid = await UserService.getUserIdFromLocal();

    CollectionReference userCollection = FirebaseFirestore.instance.collection("users");

    userCollection.doc(uid).update({
      "kategori" : categories
    });

    var box = await Hive.openBox(categoriesBoxKey);
    box.put(categoriesLocalKey, categories);
  }

  static Future<List<String>> getFromLocal() async{
    var box = await Hive.openBox(categoriesBoxKey);
    if(box.containsKey(categoriesLocalKey)){
      List<String> categories = box.get(categoriesLocalKey);
      return categories;
    }else{
      return [];
    }
  }

  static Future<int> getCountCategories() async{
    var box = await Hive.openBox(categoriesBoxKey);
    if(box.containsKey(categoriesLocalKey)){
      List<String> categories = box.get(categoriesLocalKey);
      return categories.length;
    }else{
      return 0;
    }
  }

  static Future<void> deleteFromLocal() async{
    var box = await Hive.openBox(categoriesBoxKey);
    box.clear();
  }
}