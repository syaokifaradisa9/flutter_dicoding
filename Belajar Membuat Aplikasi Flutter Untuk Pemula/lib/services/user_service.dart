part of 'services.dart';

class UserService{
  static final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");

  static Future<void> updateUser(UserModel user) async{
    _userCollection.doc(user.uid).set({
      'name' : user.name,
      'email' : user.email
    });
  }

  static Future<UserModel> getUser(String id) async{
    DocumentSnapshot snapshot = await _userCollection.doc(id).get();

    return UserModel(
      uid: id,
      name: snapshot.get("name"),
      email: snapshot.get("email")
    );
  }

  static Future<void> saveToLocal(UserModel user) async{
    var box = await Hive.openBox(userHiveKey);
    box.put(userLocalKey, user);
  }

  static Future<UserModel> getFromLocal() async{
    var box = await Hive.openBox(userHiveKey);
    UserModel user = box.get(userLocalKey);
    return user;
  }

  static Future<String> getUserIdFromLocal() async{
    var box = await Hive.openBox(userHiveKey);
    UserModel user = box.get(userLocalKey);
    return user.uid;
  }

  static Future<String> getNameFromLocal() async{
    var box = await Hive.openBox(userHiveKey);
    UserModel user = box.get(userLocalKey);
    return user.name;
  }

  static Future<void> deleteFromLocal() async{
    var box = await Hive.openBox(userHiveKey);
    box.clear();
  }
}