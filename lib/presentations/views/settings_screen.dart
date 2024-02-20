import 'package:diseases/constants/colors.dart';
import 'package:diseases/presentations/widgets/custom_drawer.dart';

import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.blueDarkColor,
          iconTheme:
              const IconThemeData(color: AppColors.greyLightColor, size: 40),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ),
        backgroundColor: AppColors.blueDarkColor,
        drawer: const CustomDrawer(),
        body: const Center(
          child: Text(
            'Configure Settings',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Istok Web',
              fontWeight: FontWeight.w700,
            ),
          ),
        ));
  }
}
