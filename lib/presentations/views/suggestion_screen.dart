import 'package:diseases/constants/colors.dart';
import 'package:diseases/presentations/widgets/custom_drawer.dart';
import 'package:diseases/presentations/widgets/custom_loader.dart';
import 'package:diseases/presentations/widgets/suggestion_card.dart';
import 'package:diseases/repositories/models/suggestions_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/cubit/speech_to_text/speech_to_text_cubit.dart';

class SuggestionsScreen extends StatelessWidget {
  const SuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = context.watch<SpeechToTextCubit>().state;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.greyLightColor,
        iconTheme: const IconThemeData(color: AppColors.primary, size: 40),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: AppColors.greyLightColor,
      drawer: const CustomDrawer(),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Based on your Suggestion\nwe are considering the following',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF761B4C),
              fontSize: 20,
              fontFamily: 'Istok Web',
              fontWeight: FontWeight.w700,
              height: 1.76,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Column(children: [
            ...state.diseases.map((disease) {
              print(disease.percentage);
              return SuggestionsCard(
                suggestion: Suggestion(
                  accuracy: disease.percentage / 100,
                  description: 'It is  Very Bad disease',
                  title: disease.name,
                ),
              );
            }).toList()
            // ...List.generate(
            //   3,
            //   (index) => const SuggestionsCard(
            //     suggestion: Suggestion(
            //         accuracy: .5,
            //         description: 'It is  Very Bad disease',
            //         title: 'Malaria'),
            //   ),
            // )
          ]),
          // Container(
          //   margin: EdgeInsets.only(top: size.width * .15),
          //   child: CircularProgressBar(
          //     color: AppColors.lightPrimary,
          //     progress: .5,
          //     radius: size.width * .15,
          //     strokeWidth: 10,
          //   ),
          // ),
          // const Text(
          //   'Loading suggestions ...',
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Color(0xFF1E1E1E),
          //     fontSize: 20,
          //     fontFamily: 'Istok Web',
          //     fontWeight: FontWeight.w700,
          //     height: 1.76,
          //   ),
          // )
        ],
      ),
    );
  }
}
