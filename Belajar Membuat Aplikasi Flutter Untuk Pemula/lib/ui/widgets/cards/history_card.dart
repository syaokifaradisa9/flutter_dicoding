part of '../widgets.dart';

class HistoryCard extends StatelessWidget {
  final int index;
  final Transaction transaction;

  const HistoryCard({
    required this.index,
    required this.transaction,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(DetailHistoryPage(
          id: transaction.id,
          totalPrice: transaction.products.sumBy((product) => (product.amount * product.product.price)),
          date: transaction.date,
        ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
              children: [
                Column(
                  children: [
                    Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        alignment: Alignment.center,
                        child: Text(
                            (index+1).toString(),
                            style: GoogleFonts.rubik(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryTextColor
                            )
                        )
                    ),
                    const SizedBox(height: 4),
                    Text(
                        dateParsing(transaction.date),
                        style: GoogleFonts.rubik(
                            color: primaryTextColor,
                            fontSize: 6
                        )
                    )
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "${transaction.products.length} Produk Terjual",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor,
                                  fontSize: 12
                              )
                          ),
                          Text(
                              "Rp.${transaction.products.sumBy((product) => (product.amount * product.product.price))}",
                              style: GoogleFonts.rubik(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.w600
                              )
                          )
                        ]
                    )
                ),
                const SizedBox(width: 14),
                const Icon(
                    Icons.chevron_right,
                    color: primaryTextColor,
                    size: 20
                )
              ]
          ),
          const Divider()
        ],
      ),
    );
  }
}
