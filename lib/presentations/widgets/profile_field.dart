import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: textTheme.displaySmall!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerLeft,
              width: size.width,
              decoration: BoxDecoration(
                  color: const Color(0xfff0f3fc),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(value,
                  style: textTheme.displaySmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      letterSpacing: .5,
                      color: Colors.black.withOpacity(.7))),
            )
          ],
        ));
  }
}
