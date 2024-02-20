import 'package:diseases/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.password = false,
      this.obsecurePassword = true});
  final String hintText;
  final TextEditingController controller;
  final bool password;
  final bool obsecurePassword;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      // margin: const EdgeInsets.only(top: 10),
      height: 100,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hintText,
              style: textTheme.displaySmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            obscureText: password && obsecurePassword,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              suffixIcon: password
                  ? obsecurePassword
                      ? const Icon(
                          Icons.visibility_off,
                          color: AppColors.primary,
                        )
                      : const Icon(
                          Icons.remove_red_eye_outlined,
                          color: AppColors.primary,
                        )
                  : null,
              fillColor: const Color(0xfff0f3fc),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            style: const TextStyle(
              fontSize: 17.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
