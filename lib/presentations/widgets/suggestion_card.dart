import 'package:diseases/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../repositories/models/suggestions_model.dart';

class SuggestionsCard extends StatelessWidget {
  final Suggestion suggestion;
  const SuggestionsCard({super.key, required this.suggestion});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                suggestion.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Istok Web',
                  fontWeight: FontWeight.w700,
                  height: 2,
                ),
              ),
              TextButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: AppColors.blueDarkColor.withOpacity(.6),
                ),
                child: Text(
                  '${(suggestion.accuracy * 100).toStringAsFixed(2)}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(
            children: [
              Container(
                height: 10,
                decoration: ShapeDecoration(
                  color: AppColors.lightPrimary, // Less shaded background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Container(
                height: 10,
                width: suggestion.accuracy *
                    size.width, // Adjust the width based on your progress
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: AppColors.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
