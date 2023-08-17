part of '../widgets.dart';

class CategoryCard extends StatelessWidget {
  final String textButton;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CategoryCard({
    required this.textButton,
    required this.onEdit,
    required this.onDelete,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          SizedBox(
              height: 40,
              width: Get.width,
              child: Row(
                  children: [
                    Expanded(
                        child: Text(
                          textButton,
                          style: GoogleFonts.rubik(
                            fontSize: 12,
                            color: primaryTextColor
                          )
                        )
                    ),
                    SmallButton(
                        text: "Edit",
                        buttonColor: editButtonColor,
                        textColor: editTextColor,
                        onTap: onEdit
                    ),
                    const SizedBox(width: 10),
                    SmallButton(
                        text: "Hapus",
                        buttonColor: deleteButtonColor,
                        textColor: deleteTextColor,
                        onTap: onDelete
                    )
                  ]
              )
          ),
          const Divider()
        ]
    );
  }
}
