part of 'services.dart';

class ProductService{
  static Future<bool> addProduct(Product product, File file) async{
    try{
      List<Product> products = await getFromLocal();
      // Pengecekan apakah data ada yang sama
      bool isCanAdded = true;
      for(int i=0; i<products.length; i++){
        if(products[i].name == product.name && products[i].price == product.price){
          isCanAdded = false;
          break;
        }
      }

      if(isCanAdded){
        UploadImageFirebaseResult res = await ImageService.uploadToFirebaseStorage(file, product.name);
        product.id = products.length;
        product.photoUrl = res.downloadUrl;

        products.add(product);

        await saveToLocal(products);
        return true;
      }else{
        return false;
      }
    }catch(e){
      return false;
    }
  }

  static Future<List<Product>> getProduct() async{
    try{
      CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();

      List data = snapshot.get("products") as List;

      List<Product> products = [];
      for(int i=0; i<data.length; i++){
        products.add(Product(
          id: data[i]['id'],
          name: data[i]['name'],
          price: data[i]['price'],
          category: data[i]['category'],
          photoUrl: data[i]['photoUrl']
        ));
      }

      return products;
    }catch(e){
      return [];
    }
  }

  static Future<bool> editProduct(int index, Product product, File editedImage) async{
    try{
      UploadImageFirebaseResult imageFirebaseResult;
      imageFirebaseResult = await ImageService.uploadToFirebaseStorage(editedImage, product.name);
      product.photoUrl = imageFirebaseResult.downloadUrl;


      List<Product> products = await getFromLocal();
      products[index] = product;

      saveToLocal(products);
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<bool> changeCategoryProduct(String category, String newCategory) async{
    try{
      List<Product> products = List<Product>.from(await getFromLocal());
      for(int i=0; i<products.length; i++){
        if(products[i].category == category){
          products[i].category = newCategory;
        }
      }

      saveToLocal(products);
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<bool> deleteProduct(int index) async{
    try{
      List<Product> products = await getFromLocal();
      await FirebaseStorage.instance.refFromURL(products[index].photoUrl!).delete();
      products.removeAt(index);
      await saveToLocal(products);
      return true;
    }catch(e){
      return false;
    }
  }

  static Future<void> deleteProductByCategory(String category) async{
    try{
      List<Product> products = await getFromLocal();
      products.removeWhere((element) => element.category == category);

      await saveToLocal(products);
    }catch(e){
      return;
    }
  }

  static Future<void> saveToLocal(List<Product> products) async{
    CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
    String uid = await UserService.getUserIdFromLocal();
    userCollection.doc(uid).update({
      "products" : products.map((e) => e.toJson()).toList()
    });

    var box = await Hive.openBox(productBoxKey);
    box.put(productLocalKey, products);
  }

  static Future<List<Product>> getFromLocal() async{
    var box = await Hive.openBox(productBoxKey);
    if(box.containsKey(productLocalKey)){
      List<Product> products = List<Product>.from(box.get(productLocalKey));
      return products;
    }else{
      return [];
    }
  }

  static Future<void> deleteFromLocal() async{
    var box = await Hive.openBox(productBoxKey);
    box.clear();
  }
}