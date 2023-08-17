part of 'shared.dart';

final AlertDialog imagePickDialog = AlertDialog(
    content: Container(
        height: Get.height * 0.2,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Sumber Pengambilan Gambar",
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.w500,
                  fontSize: 14
                )
              ),
              GestureDetector(
                  onTap: (){
                    Get.back(result: ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera_alt, size: 26),
                      const SizedBox(width: 10),
                      Text(
                        "Kamera",
                        style: GoogleFonts.rubik(fontSize: 14)
                      )
                    ],
                  )
              ),
              GestureDetector(
                  onTap: (){
                    Get.back(result: ImageSource.gallery);
                  },
                  child: Row(
                      children: [
                        Icon(Icons.photo_library, size: 26),
                        SizedBox(width: 10),
                        Text(
                          "Galeri",
                          style: GoogleFonts.rubik(fontSize: 14)
                        )
                      ]
                  )
              )
            ]
        )
    )
);