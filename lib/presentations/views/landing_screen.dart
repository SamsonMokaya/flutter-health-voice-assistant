import 'package:diseases/constants/colors.dart';
import 'package:flutter/material.dart';
import '../../routes.dart' as route;

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.greyLightColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: size.height / 2,
              width: size.width,
              color: AppColors.primary,
            ),
          ),
          Positioned(
            top: size.height / 5.5,
            child: Column(
              children: [
                Image.asset(
                    'assets/images/first_logo.png'), // Replace with your image
                const SizedBox(height: 10),
                const Text(
                  'Welcome to your\n diagnosis assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: const Offset(8, 10),
                          blurStyle: BlurStyle.solid),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(route.loginScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
