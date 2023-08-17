part of '../pages.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    if(isInit){
      isInit = false;
      provider.reset();
      setState(() {});
    }

    return GeneralPageLayout(
        title: "Tambah Produk",
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const TextLabel(value: "Nama Produk"),
                    const SizedBox(height: 8),
                    GeneralForm(
                        hint: "Masukkan Nama Produk",
                        onChange: provider.checkName
                    ),
                    const SizedBox(height: 16),
                    const TextLabel(value: "Harga Produk"),
                    const SizedBox(height: 8),
                    GeneralForm(
                        hint: "Rp. xxx.xxx (tuliskan hanya angka)",
                        inputType: TextInputType.number,
                        onChange: provider.checkPrice
                    ),
                    const SizedBox(height: 16),
                    const TextLabel(value: "Kategori Produk"),
                    const SizedBox(height: 8),
                    GeneralDropdown(
                        onChange: provider.checkCategory,
                        value: provider.category,
                        data: provider.categories
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

                          final ImagePicker _picker = ImagePicker();
                          final pickedFile = await _picker.pickImage(source: imageSource, imageQuality: 100, maxHeight: 480, maxWidth: 854);

                          provider.checkImage(File(pickedFile!.path));
                        },
                        child: Container(
                            width: 160,
                            height: 120,
                            decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(4),
                                image: provider.fileImage != null ? DecorationImage(
                                    image: FileImage(provider.fileImage!),
                                    fit: BoxFit.cover
                                ) : null
                            ),
                            alignment: Alignment.center,
                            child: provider.fileImage == null ? Text(
                                "klik untuk\nmengambil gambar",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.rubik(
                                    fontSize: 8,
                                    color: Colors.white
                                )
                            ) : const SizedBox()
                        )
                    ),
                    SizedBox(height: provider.fileImage != null ? 4 : 0),
                    provider.fileImage != null ? Text(
                        "Klik gambar jika ingin menggantinya",
                        style: GoogleFonts.rubik(
                            fontSize: 10,
                            color: Colors.black26
                        )
                    ) : const SizedBox(),
                    const SizedBox(height: 24),
                    GeneralButton(
                        textButton: "Tambahkan",
                        color: provider.isFormValid ? secondaryColor : secondaryColor.withOpacity(0.6),
                        textColor: Colors.white,
                        onTap: () async{
                          if(provider.isFormValid){
                            Product product = Product(
                              name: provider.name!,
                              price: int.parse(provider.price!),
                              category: provider.category!
                            );

                            EasyLoading.show();
                            bool res = await ProductService.addProduct(product, provider.fileImage!);
                            EasyLoading.dismiss();
                            if(res){
                              Get.back(result: true);
                            }else{
                              EasyLoading.showError("Gagal Menambah Produk, Silahkan Coba Lagi!");
                            }
                          }else{
                            EasyLoading.showError("Isikan Semua Form Terlebih Dahulu!");
                          }
                        }
                    )
                  ]
              )
            )
        )
    );
  }
}
