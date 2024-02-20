import 'package:diseases/business_logic/cubit/togglePassword/toggle_password_cubit.dart';
import 'package:diseases/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextField extends StatelessWidget {
  final bool password;
  final String label;
  final TextEditingController controller;
  final Icon? prefixIcon;
  final bool obsecurePassword;
  final bool number;
  final bool login;
  final String placeholder;
  final bool text;

  const CustomTextField(
      {super.key,
      this.label = '',
      required this.controller,
      required this.placeholder,
      this.password = false,
      this.text = true,
      this.number = false,
      this.login = false,
      this.obsecurePassword = true,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    var suffixIcon = password
        ? IconButton(
            icon: obsecurePassword
                ? const Icon(
                    Icons.visibility_off_outlined,
                    color: AppColors.secondary,
                  )
                : const Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.secondary,
                  ),
            onPressed: () {
              if (login) {
                context.read<TogglePasswordCubit>().toggleLoginPassword();
              } else {
                context.read<TogglePasswordCubit>().toggleSignUpPassword();
              }
            },
          )
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Ubuntu',
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 1,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.greyLightColor),
            borderRadius: BorderRadius.circular(5),
          ),
          child: TextField(
            controller: controller,
            obscureText: password && obsecurePassword,
            obscuringCharacter: '*',
            style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            keyboardType: number ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              hintText: placeholder,
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.redColor),
              ),
              border: InputBorder.none,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
