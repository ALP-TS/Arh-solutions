import 'package:flutter/material.dart';

import '../../../../../app/config/theme/colors.dart';

class RadiologyChip extends StatelessWidget {
  const RadiologyChip({super.key, required this.label, required this.selected});
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color:selected? AppColors.primary : AppColors.grey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circle with icon
          Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.tune, // This is close to the filter icon in your image
              color: Color(0xFF00FF66), // neon green
              size: 10,
            ),
          ),
          const SizedBox(width: 10),
           Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
