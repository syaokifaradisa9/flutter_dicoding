part of '../pages.dart';

class ProductFormEditPage extends StatefulWidget {
  final int dataIndex;
  final Product product;

  const ProductFormEditPage({
    required this.dataIndex,
    required this.product,
    Key? key
  }) : super(key: key);

  @override
  _ProductFormEditPageState createState() => _ProductFormEditPageState();
}

class _ProductFormEditPageState extends State<ProductFormEditPage> {
  bool isInit = true;

  late TextEditingController nameController;
  late TextEditingController priceController;

  late List<String> categories;
  late String category;
  late String photoUrl;
  File? editedImage;

  Future<void> initCategories() async{
    categories = await CategoryService.getFromLocal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(isInit){
      nameController = TextEditingController(text: widget.product.name);
      priceController = TextEditingController(text: widget.product.price.toString());
      category = widget.product.category;
      photoUrl = widget.product.photoUrl!;
      isInit = false;

      initCategories();
    }

    return GeneralPageLayout(
      title: "Ubah Produk",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const TextLabel(value: "Nama Produk"),
                const SizedBox(height: 8),
                ControllerForm(
                  controller: nameController,
                  hint: "Masukkan Nama Produk",
                ),
                const SizedBox(height: 16),
                const TextLabel(value: "Harga Produk"),
                const SizedBox(height: 8),
                ControllerForm(
                  hint: "Rp. xxx.xxx (tuliskan hanya angka)",
                  controller: priceController
                ),
                const SizedBox(height: 16),
                const TextLabel(value: "Kategori Produk"),
                const SizedBox(height: 8),
                GeneralDropdown(
                    onChange: (value){
                      category = value;
                      setState(() {});
                    },
                    value: category,
                    data: categories
                ),
                const SizedBox(height: 16),
                const TextLabel(value: "Foto Produk"),
                const SizedBox(height: 8),
                GestureDetector(
                    onTap: () async{
                      ImageSource imageSource = await showDialog(
                          context: context,
                          builder: (context) => imagePickDialog
                      );

                      final ImagePicker picker = ImagePicker();
                      final pickedFile = await picker.pickImage(source: imageSource, imageQuality: 100, maxHeight: 480, maxWidth: 854);

                      editedImage = File(pickedFile!.path);
                      setState(() {});
                    },
                    child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(4),
                            image: editedImage == null ? DecorationImage(
                                image:  NetworkImage(photoUrl),
                                fit: BoxFit.cover
                            ) :
                            DecorationImage(
                              image:  FileImage(editedImage!),
                              fit: BoxFit.cover
                            )
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            "klik untuk\nmengambil gambar",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                                fontSize: 8,
                                color: Colors.white
                            )
                        )
                    )
                ),
                const SizedBox(height: 4),
                 Text(
                    "Klik gambar jika ingin menggantinya",
                    style: GoogleFonts.rubik(
                        fontSize: 10,
                        color: Colors.black26
                    )
                ),
                const SizedBox(height: 24),
                GeneralButton(
                    textButton: "Ubah",
                    color: secondaryColor,
                    textColor: Colors.white,
                    onTap: () async{
                      String name = nameController.text;
                      String price = priceController.text;

                      Product product = Product(
                        id: 0,
                        name: name,
                        category: category,
                        price: int.parse(price),
                        photoUrl: photoUrl
                      );

                      EasyLoading.show();
                      bool res = await ProductService.editProduct(widget.dataIndex, product, editedImage!);
                      EasyLoading.dismiss();

                      if(res){
                        Get.back(result: true);
                      }else{
                        EasyLoading.showError("Ubah Produk Gagal, Silahkan Coba Lagi!");
                      }
                    }
                )
              ]
          )
        ),
      )
    );
  }
}
