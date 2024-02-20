import 'package:diseases/constants/colors.dart';
import 'package:flutter/material.dart';

class TabHeader extends StatelessWidget {
  const TabHeader({
    super.key,
    required this.size,
    this.title = const SizedBox(),
    this.subtitle = const SizedBox(),
    this.button = const SizedBox(),
    this.image = const SizedBox(),
  });

  final Size size;
  final Widget title;
  final Widget subtitle;
  final Widget button;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .18,
      width: size.width,
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  const SizedBox(
                    height: 10,
                  ),
                  subtitle,
                  button
                ],
              ),
            ),
            Expanded(flex: 2, child: image)
          ],
        ),
      ),
    );
  }
}
