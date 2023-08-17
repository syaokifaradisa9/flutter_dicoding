part of '../widgets.dart';

class OrderCard extends StatelessWidget {
  final String productName;
  final String price;
  final String imageUrl;
  final VoidCallback onIncreaseAmount;
  final VoidCallback onDecreaseAmount;
  final int amount;

  const OrderCard({
    required this.productName,
    required this.price,
    required this.imageUrl,
    required this.onDecreaseAmount,
    required this.onIncreaseAmount,
    required this.amount,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 14),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl)
                    )
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          productName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.rubik(
                            fontSize: 11,
                            color: primaryTextColor,
                            fontWeight: FontWeight.w600
                          )
                      ),
                      Text(
                        "Rp.$price",
                        style: GoogleFonts.rubik(
                          color: secondaryColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600
                        )
                      )
                    ]
                )
              ),
              GestureDetector(
                onTap: onDecreaseAmount,
                child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: amount != 1 ? const Color.fromRGBO(232, 242, 252, 1) : const Color.fromRGBO(254, 184, 200, 1),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    alignment: Alignment.center,
                    child: amount != 1 ? Text(
                      "-",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(0, 133, 233, 1),
                          fontSize: 16
                      ),
                    ) : const Icon(
                      Icons.delete,
                      size: 15,
                      color: Color.fromRGBO(248, 76, 115, 1),
                    )
                ),
              ),
              const SizedBox(width: 12),
              Text(
                amount.toString(),
                style: GoogleFonts.rubik(
                  color: Colors.black,
                  fontSize: 14
                )
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onIncreaseAmount,
                child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(232, 242, 252, 1),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "+",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w600,
                          color: const Color.fromRGBO(0, 133, 233, 1),
                          fontSize: 16
                      ),
                    )
                )
              )
            ]
        )
    );
  }
}
