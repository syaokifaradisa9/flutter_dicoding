part of '../widgets.dart';

class CategoryProductCard extends StatelessWidget {
  final String category;
  final VoidCallback onTap;
  final int currentIndex;
  final int categoryIndex;

  const CategoryProductCard({
    required this.category,
    required this.currentIndex,
    required this.categoryIndex,
    required this.onTap,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
              color: categoryIndex == currentIndex ? secondaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4
          ),
          alignment: Alignment.center,
          child: Text(
              category,
              style: GoogleFonts.rubik(
                fontSize: 11,
                fontWeight: categoryIndex == currentIndex ? FontWeight.w600 : FontWeight.w500,
                color: categoryIndex == currentIndex ? Colors.white : primaryTextColor.withOpacity(0.6)
              )
          )
      ),
    );
  }
}
