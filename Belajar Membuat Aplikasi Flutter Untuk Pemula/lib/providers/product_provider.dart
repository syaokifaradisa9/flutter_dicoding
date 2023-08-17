part of 'providers.dart';

class ProductProvider with ChangeNotifier{
  bool isFormValid = false;
  List<String> categories = [];

  String? name;
  String? price;
  String? category;
  File? fileImage;

  void reset() async{
    isFormValid = false;
    name = "";
    price = "";
    category = "";
    fileImage = null;
    categories = await CategoryService.getFromLocal();
    notifyListeners();
  }

  void checkName(dynamic value){
    name = value;
    checkFormValidation();
  }

  void checkPrice(dynamic value){
    price = value;
    checkFormValidation();
  }

  void checkImage(File file){
    fileImage = file;
    checkFormValidation();
  }

  void checkCategory(dynamic value){
    category = value.toString();
    checkFormValidation();
  }

  void checkFormValidation(){
    if(name!.isNotEmpty && price!.isNotEmpty && int.parse(price!) > 0 && fileImage != null && category!.isNotEmpty){
      isFormValid = true;
    }else{
      isFormValid = false;
    }

    notifyListeners();
  }
}