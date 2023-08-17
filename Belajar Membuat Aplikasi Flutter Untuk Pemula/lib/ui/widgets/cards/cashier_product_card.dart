part of '../widgets.dart';

class CashierProductCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final VoidCallback onTap;

  const CashierProductCard({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.onTap,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 1), // changes position of shadow
            )
          ]
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(6),
                    topLeft: Radius.circular(6)
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover
                  )
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.rubik(
                      fontSize: 10,
                      color: primaryTextColor,
                      fontWeight: FontWeight.bold
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                    "Rp.$price",
                    style: GoogleFonts.rubik(
                        fontSize: 9,
                        color: secondaryColor,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              const Spacer(),
            ]
        )
      )
    );
  }
}
