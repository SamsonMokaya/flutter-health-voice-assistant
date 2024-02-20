import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class PieChart extends StatelessWidget {
  const PieChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: Colors.transparent, // Transparent inside
          style: BorderStyle.solid,
        ),
        gradient: const SweepGradient(
          colors: [
            AppColors.lightPrimary, // Light primary color
            AppColors.primary, // Dark primary color
          ],
          stops: [0.5, 0.5], // Split the gradient at 50% for the two halves
          startAngle: 0.0,
          endAngle: 3.14, // 180 degrees in radians, for a semi-circle
        ),
      ),
    );
  }
}
