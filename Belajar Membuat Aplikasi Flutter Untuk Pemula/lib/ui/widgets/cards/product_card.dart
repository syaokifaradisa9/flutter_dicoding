part of '../widgets.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ProductCard({
    required this.product,
    required this.onEdit,
    required this.onDelete,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 4),
        Row(
            children: [
              Image.network(
                  product.photoUrl!,
                  width: 80,
                  height: 60,
                  fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                    height: 65,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              product.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.rubik(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: primaryTextColor
                              )
                          ),
                          const SizedBox(height: 3),
                          Text(
                              "Rp. ${product.price.toString()}",
                              style: GoogleFonts.rubik(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: secondaryColor
                              )
                          ),
                          const Spacer(),
                          Row(
                              children: [
                                SmallButton(
                                    text: "Edit",
                                    textColor: editTextColor,
                                    buttonColor: editButtonColor,
                                    onTap: onEdit
                                ),
                                const SizedBox(width: 4),
                                SmallButton(
                                    text: "Hapus",
                                    textColor: deleteTextColor,
                                    buttonColor: deleteButtonColor,
                                    onTap: onDelete
                                )
                              ]
                          )
                        ]
                    )
                )
              )
            ]
        ),
        const SizedBox(height: 4),
        const Divider()
      ]
    );
  }
}
