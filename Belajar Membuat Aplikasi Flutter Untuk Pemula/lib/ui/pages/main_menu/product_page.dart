part of '../pages.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<int>(
          future: CategoryService.getCountCategories(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              if(snapshot.data != 0){
                return Column(
                    children: [
                      const SizedBox(height: 14),
                      Expanded(
                          child: FutureBuilder<List<Product>>(
                              future: ProductService.getFromLocal(),
                              builder: (context, snapshot){
                                if(snapshot.connectionState == ConnectionState.done){
                                  if(snapshot.data!.isNotEmpty){
                                    return ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) => ProductCard(
                                          product: snapshot.data![index],
                                          onEdit: () async{
                                            bool isEdited = await Get.to(ProductFormEditPage(dataIndex: index, product: snapshot.data![index]));
                                            if(isEdited){
                                              setState(() {});
                                              EasyLoading.showSuccess("Sukses Mengubah Produk");
                                            }
                                          },
                                          onDelete: () async{
                                            bool isDelete = await showConfirmationAlert(
                                                context: context,
                                                question: "Yakin ingin menghapus produk?"
                                            );

                                            if(isDelete){
                                              EasyLoading.show();
                                              bool res = await ProductService.deleteProduct(index);
                                              EasyLoading.dismiss();
                                              if(res){
                                                setState(() {});
                                                EasyLoading.showSuccess("Sukses Menghapus Produk");
                                              }else{
                                                EasyLoading.showError("Gagal Menghapus Produk, Silahkan Coba Lagi!");
                                              }
                                            }
                                          },
                                        )
                                    );
                                  }else{
                                    return Center(
                                        child: Text(
                                            "Produk Kosong",
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
                          textButton: "Tambah Produk",
                          color: secondaryColor,
                          textColor: Colors.white,
                          onTap: () async{
                            bool isAdded = await Get.to(const ProductFormPage());
                            if(isAdded){
                              setState(() {});
                              EasyLoading.showSuccess("Tambah Produk Sukses!");
                            }
                          }
                      ),
                      const SizedBox(height: 14)
                    ]
                );
              }else{
                return Center(
                    child: Text(
                      "Kategori Anda Masih Kosong\nSilahkan Tambahkan Kategori Terlebih Dahulu",
                      textAlign: TextAlign.center,
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
    );
  }
}
