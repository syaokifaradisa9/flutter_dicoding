part of '../pages.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            children: [
              const SizedBox(height: 14),
              Expanded(
                  child: FutureBuilder<List<String>>(
                    future: CategoryService.getFromLocal(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        if(snapshot.data!.isNotEmpty){
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => CategoryCard(
                                textButton: snapshot.data![index],
                                onEdit: () async{
                                  bool res = await Get.to(CategoryFormPage(dataInit: snapshot.data![index]));
                                  if(res){
                                    setState(() {});
                                    EasyLoading.showSuccess("Sukses Mengedit Kategori");
                                  }
                                },
                                onDelete: () async{
                                  bool isDelete = await showConfirmationAlert(
                                      context: context,
                                      question: "Yakin ingin menghapus kategori? semua produk dengan kategori ini juga akan dihapus!"
                                  );

                                  if(isDelete){
                                    await CategoryService.deleteCategory(snapshot.data![index]);
                                    setState(() {});
                                    EasyLoading.showSuccess("Sukses Menghapus Kategori");
                                  }
                                },
                              )
                          );
                        }else{
                          return Center(
                            child: Text(
                              "Kategori Kosong",
                              style: GoogleFonts.rubik(
                                fontSize: 11,
                                color: Colors.black45
                              )
                            )
                          );
                        }
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                  )
              ),
              GeneralButton(
                  textButton: "Tambah Kategori",
                  color: secondaryColor,
                  textColor: Colors.white,
                  onTap: () async{
                    bool isDataAdded = await Get.to(const CategoryFormPage());
                    if(isDataAdded){
                      setState(() {});
                      EasyLoading.showSuccess("Tambah Kategori Sukses!");
                    }
                  }
              ),
              const SizedBox(height: 14)
            ]
        )
    );
  }
}

