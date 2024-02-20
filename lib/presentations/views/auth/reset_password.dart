import 'package:diseases/presentations/widgets/success_dialogue.dart';
import 'package:diseases/presentations/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:diseases/routes.dart' as route;

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        // Set the app bar background color
        elevation: 0, // Remove app bar elevation
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black.withOpacity(.1)),
                  child: CustomTextField(
                    label: 'New Password',
                    placeholder: '********',
                    controller: newPasswordController,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black.withOpacity(.1)),
                  child: CustomTextField(
                    label: 'Confirm Password',
                    placeholder: '********',
                    controller: confirmPasswordController,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final String password = newPasswordController.text;
                    final String confirmPassword =
                        confirmPasswordController.text;
                    if (confirmPassword.isNotEmpty && password.isNotEmpty) {
                      password == confirmPassword
                          ? successDialog(
                              context: context,
                              success: true,
                              route: route.loginScreen,
                              message: 'Password updated successfully',
                              title: 'Savey')
                          : _buildDialog(
                              context: context,
                              title: 'Error',
                              content: " Passwords do not match",
                            );
                      // Validate if any field is empty
                    } else {
                      _buildDialog(
                        context: context,
                        title: 'Error',
                        content: 'Please fill all fields',
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _buildDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
