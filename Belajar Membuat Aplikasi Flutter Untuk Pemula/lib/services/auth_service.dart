part of 'services.dart';

class AuthService{
  static Future<SignInSignUpResult> signInWithEmail(String email, String password) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    try{
      var result = await auth.signInWithEmailAndPassword(email: email, password: password);

      UserModel user = await UserService.getUser(result.user!.uid);
      await UserService.saveToLocal(user);

      List<String> categories = await CategoryService.getCategory();
      if(categories.isNotEmpty) {
        await CategoryService.saveToLocal(categories);
      }

      List<Product> products = await ProductService.getProduct();
      if(products.isNotEmpty) {
        await ProductService.saveToLocal(products);
      }

      return SignInSignUpResult(user: user);
    }catch(e){
      return SignInSignUpResult(message: e.toString().split("]")[0].split("/")[1]);
    }
  }

  static Future<SignInSignUpResult> signUpWithEmail(String email, String password, String name) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    try{
      var result = await auth.createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
        uid: result.user!.uid,
        name: name,
        email: email
      );

      await UserService.updateUser(user);

      return SignInSignUpResult(user: user);
    }catch(e){
      return SignInSignUpResult(message: e.toString().split("]")[0].split("/")[1]);
    }
  }

  static Future<void> signOut() async{
    FirebaseAuth auth = FirebaseAuth.instance;

    await CategoryService.deleteFromLocal();
    await ProductService.deleteFromLocal();
    await TransactionService.deleteFromLocal();

    await auth.signOut();

    Get.offAll(const LoginPage());
  }

  static Future<String> resetPassword(String email) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    try{
      await auth.sendPasswordResetEmail(email: email);
      return "Sukses";
    }catch(e){
      return e.toString().split("]")[0].split("/")[1];
    }
  }
}

class SignInSignUpResult{
  final UserModel? user;
  final String? message;

  SignInSignUpResult({
    this.user,
    this.message
  });
}