part of '../pages.dart';

class CategoryFormPage extends StatefulWidget {
  // dataInit akan bernilai null jika menambahkan data baru dan berisi apabila user ingin mengedit kategori
  final String? dataInit;
  const CategoryFormPage({
    this.dataInit,
    Key? key
  }) : super(key: key);

  @override
  _CategoryFormPageState createState() => _CategoryFormPageState();
}

class _CategoryFormPageState extends State<CategoryFormPage> {
  late final TextEditingController inputController;
  String category = "";
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    if(widget.dataInit != null){
      inputController = TextEditingController(text: widget.dataInit);
      isInit = false;
      setState(() {});
    }

    return GeneralPageLayout(
        title: widget.dataInit == null ? "Tambah Kategori" : "Ubah Kategori",
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const TextLabel(value: "Kategori"),
                  const SizedBox(height: 8),
                  widget.dataInit == null ? GeneralForm(
                      hint: "Nama Kategori",
                      onChange: (value){
                        category = value;
                        setState(() {});
                      }
                  ) : ControllerForm(
                    controller: inputController,
                    hint: "Nama Kategori",
                  ),
                  const SizedBox(height: 16),
                  GeneralButton(
                    textButton: widget.dataInit == null ? "Tambahkan" : "Ubah",
                    color: secondaryColor,
                    textColor: Colors.white,
                    onTap: () async{
                      // Tambah Data
                      if(widget.dataInit == null){
                        if(category.isNotEmpty){
                          EasyLoading.show();
                          bool res = await CategoryService.addCategory(category);
                          EasyLoading.dismiss();

                          if(res){
                            Get.back(result: true);
                          }else{
                            EasyLoading.showError("Tambah Kategori Gagal, Silahkan Coba Lagi!");
                          }
                        }else{
                          EasyLoading.showError("Isikan Form Kategori Terlebih Dahulu!");
                        }
                      }
                      // Edit Data
                      else{
                        if(widget.dataInit!.toLowerCase() != inputController.text.toLowerCase()){
                          bool res = await CategoryService.editCategory(widget.dataInit!, inputController.text);
                          if(res){
                            Get.back(result: true);
                          }else{
                            EasyLoading.showError("Gagal Mengubah Kategori, Silahkan Coba Lagi!");
                          }
                        }else{
                          EasyLoading.showError("Nama Kategori Belum Anda Ubah!");
                        }
                      }
                    }
                  )
                ]
            )
        )
    );
  }
}

