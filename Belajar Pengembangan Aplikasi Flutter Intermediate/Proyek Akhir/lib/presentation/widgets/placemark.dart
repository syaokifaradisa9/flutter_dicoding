import 'package:flutter/material.dart';
import 'package:story_app/config/colors.dart';
import 'package:story_app/config/localization.dart';
import 'package:story_app/presentation/widgets/button.dart';

class PlaceMark extends StatelessWidget {
  final String street;
  final String address;
  final VoidCallback onSelectLocation;

  const PlaceMark({
    required this.street,
    required this.address,
    required this.onSelectLocation,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      constraints: const BoxConstraints(maxWidth: 700),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 5,
            offset: Offset.zero,
            color: Colors.grey.withOpacity(0.5),
          )
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  street,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  address,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w400
                  ),
                ),
                const SizedBox(height: 12),
                Button(
                  onTap: onSelectLocation,
                  buttonColor: primaryColor,
                  textColor: Colors.white,
                  icon: Icons.location_on,
                  textLabel: AppLocalizations.of(context)!.chooseLocationLabel
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
