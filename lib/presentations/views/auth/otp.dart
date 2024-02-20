import 'package:diseases/business_logic/bloc/auth_status/auth_status_bloc.dart';
import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../routes.dart' as route;

class Otp extends StatefulWidget {
  final VoidCallback? onPressed;
  final String email;
  final String password;
  const Otp(
      {super.key, this.onPressed, required this.email, required this.password});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final TextEditingController _firstController = TextEditingController();

  final TextEditingController _secondController = TextEditingController();

  final TextEditingController _thirdController = TextEditingController();

  final TextEditingController _fourthController = TextEditingController();

  final TextEditingController _fifthController = TextEditingController();

  final TextEditingController _sixthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xfff7f6fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, route.loginScreen),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(.1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset('assets/images/otp.svg',
                    semanticsLabel: 'OTP'),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Verification',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter your OTP code number",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 28,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _textFieldOTP(
                            first: true,
                            last: false,
                            context: context,
                            controller: _firstController),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: _secondController),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: _thirdController),
                        _textFieldOTP(
                            first: false,
                            last: false,
                            context: context,
                            controller: _fourthController),
                        _textFieldOTP(
                          context: context,
                          controller: _fifthController,
                          first: false,
                          last: false,
                        ),
                        _textFieldOTP(
                          context: context,
                          controller: _sixthController,
                          first: false,
                          last: true,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(Login(
                                    email: widget.email,
                                    password: widget.password,
                                    otp: _firstController.text +
                                        _secondController.text +
                                        _thirdController.text +
                                        _fourthController.text +
                                        _fifthController.text +
                                        _sixthController.text,
                                  ));
                              context
                                  .read<AuthStatusBloc>()
                                  .add(CheckUserStatus());
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  AppColors.primary),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: (state is LoginInProgress)
                                  ? const CupertinoActivityIndicator(
                                      color: AppColors.whiteColor,
                                    )
                                  : const Text(
                                      'Verify',
                                      style: TextStyle(fontSize: 16),
                                    ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Didn't you receive any code?",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 18,
              ),
              const Text(
                "Resend New Code",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP(
      {required bool first,
      last,
      required TextEditingController controller,
      required BuildContext context}) {
    return SizedBox(
      height: 65,
      child: AspectRatio(
        aspectRatio: .70,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 2, color: AppColors.primary),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
