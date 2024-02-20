import 'package:diseases/business_logic/bloc/authentication/authentication_bloc.dart';
import 'package:diseases/business_logic/cubit/togglePassword/toggle_password_cubit.dart';
import 'package:diseases/constants/colors.dart';
import 'package:diseases/presentations/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../routes.dart' as route;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = context.watch<TogglePasswordCubit>().state;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.lightPrimary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ]),
              height: size.height * .85,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registration',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  ),
                  Container(
                    height: 3.7,
                    width: 40,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.lightPrimary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextField(
                        label: 'First Name',
                        controller: _firstNameController,
                        prefixIcon: const Icon(Icons.person_2_sharp),
                        placeholder: 'John',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Last Name',
                        controller: _lastNameController,
                        prefixIcon: const Icon(Icons.person_2_sharp),
                        placeholder: 'Doe',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Email',
                        controller: _emailController,
                        prefixIcon: const Icon(Icons.email_rounded),
                        placeholder: 'example@email.com',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Enter Password',
                        controller: _passwordController,
                        password: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obsecurePassword: state.passwordSignUpVisible,
                        placeholder: '********',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      CustomTextField(
                        label: 'Confirm Password',
                        controller: _confirmPasswordController,
                        password: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                        obsecurePassword: state.passwordSignUpVisible,
                        placeholder: '********',
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.primary,
                              AppColors.lightPrimary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            fixedSize: Size(size.width, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            //check if the email fit this format textnumber@daystar.ac.ke with regular expression and also check if all fields are filled
                            if (_emailController.text.isEmpty ||
                                _passwordController.text.isEmpty ||
                                _firstNameController.text.isEmpty ||
                                _lastNameController.text.isEmpty ||
                                _confirmPasswordController.text.isEmpty) {
                              Fluttertoast.showToast(
                                  msg: 'Please fill all fields');
                            } else {
                              //validate the email using regular expression
                              final RegExp emailRegex = RegExp(
                                  r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                              if (!emailRegex.hasMatch(_emailController.text)) {
                                Fluttertoast.showToast(
                                    msg: 'Please enter a valid Daystar email');
                              } else {
                                if (_passwordController.text !=
                                    _confirmPasswordController.text) {
                                  Fluttertoast.showToast(
                                      msg: 'Passwords do not match');
                                } else {
                                  BlocProvider.of<AuthBloc>(context)
                                      .add(Register(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                  ));
                                }
                              }
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is RegistrationInProgress) {
                                return const CupertinoActivityIndicator(
                                    color: AppColors.whiteColor);
                              } else {
                                return const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontFamily: 'Ubuntu',
                                      fontSize: 20,
                                      color: AppColors.whiteColor),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(route.loginScreen);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: const Text.rich(
                            TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(
                                fontFamily: 'Ubuntu',
                                fontSize: 16,
                                color: AppColors.blackColor,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: TextStyle(
                                    fontFamily: 'Ubuntu',
                                    fontSize: 16,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
