part of '../pages.dart';

class DetailHistoryPage extends StatelessWidget {
  final int id;
  final int totalPrice;
  final String date;

  const DetailHistoryPage({
    required this.id,
    required this.totalPrice,
    required this.date,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GeneralPageLayout(
      title: "Detail Transaksi",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                "Informasi Transaksi",
                style: formLabelTextStyle.copyWith(
                  fontSize: 12
                )
              ),
              const SizedBox(height: 6),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Tanggal",
                        style: GoogleFonts.rubik(
                            fontSize: 12
                        )
                    ),
                    Text(
                        dateParsing(date),
                        style: GoogleFonts.rubik(
                          fontSize: 12
                        )
                    )
                  ]
              ),
              const SizedBox(height: 6),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Jam",
                        style: GoogleFonts.rubik(
                            fontSize: 12
                        )
                    ),
                    Text(
                        timeParsing(date),
                        style: GoogleFonts.rubik(
                            fontSize: 12
                        )
                    )
                  ]
              ),
              const SizedBox(height: 6),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "Total Harga",
                        style: GoogleFonts.rubik(
                            fontSize: 12
                        )
                    ),
                    Text(
                        "Rp.$totalPrice",
                        style: GoogleFonts.rubik(
                          fontSize: 12
                        )
                    )
                  ]
              ),
              const SizedBox(height: 4),
              const Divider(),
              const SizedBox(height: 4),
              Text(
                  "Produk Terjual",
                  style: formLabelTextStyle.copyWith(
                      fontSize: 12
                  )
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<DetailTransaction>>(
                    future: TransactionService.getDetailTransactionById(id),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.done){
                        return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) => Column(
                                children: [
                                  const SizedBox(height: 4),
                                  Row(
                                      children: [
                                        Container(
                                            width: 52,
                                            height: 45,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot.data![index].product.photoUrl!),
                                                fit: BoxFit.cover
                                              ),
                                              borderRadius: BorderRadius.circular(8)
                                            )
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    snapshot.data![index].product.name,
                                                    style: GoogleFonts.rubik(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                        color: primaryTextColor
                                                    )
                                                ),
                                                const SizedBox(height: 3),
                                                Text(
                                                    "Rp. ${snapshot.data![index].product.price.toString()}",
                                                    style: GoogleFonts.rubik(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600,
                                                        color: secondaryColor
                                                    )
                                                )
                                              ]
                                          )
                                        ),
                                        Text(
                                          "x ${snapshot.data![index].amount}",
                                          style: GoogleFonts.rubik(
                                            color: primaryTextColor,
                                            fontWeight: FontWeight.w400
                                          )
                                        )
                                      ]
                                  ),
                                  const SizedBox(height: 4),
                                  const Divider()
                                ]
                            )
                        );
                      }else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    }
                )
              )
            ]
        )
      )
    );
  }
}
