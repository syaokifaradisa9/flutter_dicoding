part of '../widgets.dart';

class GeneralDropdown extends StatelessWidget {
  final dynamic value;
  final List<dynamic> data;
  final void Function(dynamic value) onChange;

  const GeneralDropdown({
    super.key,
    required this.value,
    required this.data,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        width: Get.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: formBackgroundColor
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: DropdownButton(
            hint: Text("Pilih Kategori", style: formPlaceholderTextStyle),
            isExpanded: true,
            dropdownColor: Colors.white,
            underline: const SizedBox(),
            value: value != "" ? value : null,
            items: data.map((value){
              return DropdownMenuItem(
                  value: value,
                  child: Text(value, style: GoogleFonts.rubik(
                      fontSize: 12,
                      color: primaryTextColor
                  ))
              );
            }
            ).toList(),
            onChanged: onChange
        )
    );
  }
}
