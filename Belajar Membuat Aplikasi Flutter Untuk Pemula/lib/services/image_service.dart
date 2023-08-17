part of 'services.dart';

class ImageService{
  static Future<UploadImageFirebaseResult> uploadToFirebaseStorage(File file, String fileName) async{
    try{
      // Compress Image
      File compressedFile = await FlutterNativeImage.compressImage(file.path, quality: 80, percentage: 70);
      String dir = path.dirname(compressedFile.path);
      String newFileName = "$fileName.jpg";
      String newPath = path.join(dir, newFileName);

      // Membuat File Baru
      File newFile = await File(compressedFile.path).copy(newPath);
      String newFileUploadPath = path.basename(newFile.path);

      // Upload Image Ke Firebase Storage
      String uid = await UserService.getUserIdFromLocal();
      var firebaseStorageRef = FirebaseStorage.instance.ref().child("$uid/produk/$newFileUploadPath");
      var uploadTask = await firebaseStorageRef.putFile(newFile);

      var taskSnapshot = uploadTask.state;
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      return UploadImageFirebaseResult(
          status: taskSnapshot == TaskState.success,
          downloadUrl: downloadUrl
      );
    }catch(e){
      return UploadImageFirebaseResult(
          status: false,
          downloadUrl: ""
      );
    }
  }
}

class UploadImageFirebaseResult{
  bool? status;
  String? downloadUrl;

  UploadImageFirebaseResult({
    this.status,
    this.downloadUrl
  });
}