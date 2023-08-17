part of '../pages.dart';

class CashierPage extends StatefulWidget {
  const CashierPage({Key? key}) : super(key: key);

  @override
  _CashierPageState createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  bool isInit = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CashierProvider>(context);
    if(isInit){
      provider.reset();
      isInit = false;
      setState(() {});
    }

    return SizedBox(
        width: Get.width,
        height: Get.height,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Container(
                      height: Get.height,
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          // NOTES : Kategori
                          const SizedBox(height: 10),
                          SizedBox(
                              height: 23,
                              width: Get.width,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.categories.length,
                                  itemBuilder: (context, index) => CategoryProductCard(
                                      category: provider.categories[index],
                                      categoryIndex: index,
                                      currentIndex: provider.currentCategoryIndex,
                                      onTap: (){
                                        provider.changeProductCategory(index);
                                      }
                                  )
                              )
                          ),
                          const SizedBox(height: 10),

                          // NOTES : Produk
                          Expanded(
                              child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: provider.filteredProducts.isNotEmpty ? GridView.count(
                                      crossAxisCount: 4,
                                      childAspectRatio: (6/7),
                                      children: provider.filteredProducts.map((product) => CashierProductCard(
                                        name: product.name,
                                        price: product.price.toString(),
                                        imageUrl: product.photoUrl!,
                                        onTap: (){
                                          provider.addOrderProduct(product.id!);
                                        },
                                      )).toList()
                                  ) : Center(
                                      child: Text(
                                        "Produk Kosong",
                                        style: GoogleFonts.rubik(
                                          fontSize: 10,
                                          color: primaryTextColor
                                        )
                                      )
                                  )
                              )
                          )
                        ],
                      )
                  )
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                    "Pesanan",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.bold,
                        fontSize: 12
                    )
                ),
              ),
              const SizedBox(height: 10),
              Container(
                  height: Get.height * 0.25,
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: provider.orderedProduct.isNotEmpty ? ListView.builder(
                      itemCount: provider.orderedProduct.length,
                      itemBuilder: (context, index) => OrderCard(
                          productName: provider.orderedProduct[index].product.name,
                          price: provider.orderedProduct[index].product.price.toString(),
                          imageUrl: provider.orderedProduct[index].product.photoUrl!,
                          amount: provider.orderedProduct[index].amount,
                          onDecreaseAmount: (){
                            provider.decreaseAmountOrder(index);
                          },
                          onIncreaseAmount: (){
                            provider.increaseAmountOrder(index);
                          }
                      )
                  ) : Center(
                      child: Text(
                          "Pesanan Kosong",
                          style: GoogleFonts.rubik(
                              fontSize: 10,
                              color: primaryTextColor
                          )
                      )
                  )
              ),
              const Divider(),
              const SizedBox(height: 2),
              Container(
                  height: 73,
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Total Harga",
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  )
                              ),
                              Text(
                                  "Rp.${provider.orderedProduct.sumBy((transaction) => (transaction.amount * transaction.product.price))}",
                                  style: GoogleFonts.rubik(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600
                                  )
                              )
                            ]
                        ),
                        const SizedBox(height: 6),
                        GeneralButton(
                            textButton: "Bayar",
                            color: secondaryColor,
                            textColor: Colors.white,
                            onTap: () async{
                              if(provider.orderedProduct.isNotEmpty){
                                bool res = await TransactionService.saveTransaction(provider.orderedProduct);
                                if(res){
                                  provider.resetTransaction();
                                  EasyLoading.showSuccess('Transaksi Sukses');
                                }else{
                                  EasyLoading.showError("Transaksi Gagal, Silahkan Coba Lagi!");
                                }
                              }else{
                                EasyLoading.showError("Anda belum Memilih Produk Yang Ingin Dijual!");
                              }
                            }
                        ),
                        const SizedBox(height: 6)
                      ]
                  )
              )
            ]
        )
    );
  }
}

