part of '../pages.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColor,
        width: Get.width,
        height: Get.height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
            children: [
              const SizedBox(height: 14),
              Expanded(
                  child: FutureBuilder<List<trans_model.Transaction>>(
                      future: TransactionService.getTransaction(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.done){
                          if(snapshot.data!.isNotEmpty){
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) => HistoryCard(
                                  index: index,
                                  transaction: snapshot.data![index]
                                )
                            );
                          }else{
                            return Center(
                                child: Text(
                                  "Transaksi Kosong",
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
              const SizedBox(height: 14)
            ]
        )
    );
  }
}
