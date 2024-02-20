import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:diseases/business_logic/bloc/extract_symptoms/extract_symptoms_bloc.dart';
import 'package:diseases/business_logic/cubit/speech_to_text/speech_to_text_cubit.dart';
import 'package:diseases/constants/colors.dart';
import 'package:diseases/constants/constants.dart';
import 'package:diseases/presentations/widgets/custom_drawer.dart';
import 'package:diseases/presentations/widgets/success_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../routes.dart' as route;

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  SpeechToText speech = SpeechToText();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final state = context.watch<SpeechToTextCubit>().state;
    var text = state.text;
    var isListening = state.isListening;
    var message = state.message;
    final TextEditingController _symptomsController = state.controller;
    print(jsonEncode(currentUser));

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.primary,
          iconTheme: const IconThemeData(color: Colors.white, size: 40),
        ),
        backgroundColor: AppColors.primary,
        drawer: const CustomDrawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset('assets/images/second_logo.png',
                width: size.width / 2, height: size.width / 1.8),
            Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: ShapeDecoration(
                color: AppColors.greyLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Center(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF2A325F),
                    fontSize: 20,
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                AvatarGlow(
                  endRadius: size.width / 5,
                  animate: isListening,
                  duration: const Duration(milliseconds: 2000),
                  repeat: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  showTwoGlows: true,
                  glowColor: AppColors.greyLightColor,
                  child:
                      BlocListener<ExtractSymptomsBloc, ExtractSymptomsState>(
                    listener: (_, stateSymptoms) {
                      if (stateSymptoms is ExtractSymptomsLoading) {
                        context.read<SpeechToTextCubit>().toggleLoading(true);
                      } else {
                        context.read<SpeechToTextCubit>().toggleLoading(false);
                      }
                      if (stateSymptoms is ExtractSymptomsError) {
                        print(stateSymptoms.errorMessage);
                        Fluttertoast.showToast(
                            msg: stateSymptoms.errorMessage,
                            backgroundColor: Colors.red);
                      } else if (stateSymptoms is ExtractSymptomsSuccess) {
                        if (stateSymptoms.symptomsArray.isEmpty) {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: 'No symptoms found from the words',
                              backgroundColor: Colors.red);
                          return;
                        }
                        Fluttertoast.showToast(
                            msg: 'Symptoms extracted successfully',
                            backgroundColor: Colors.green);
                        _symptomsController.text =
                            stateSymptoms.extractedSymptoms.join(', ');
                        context
                            .read<SpeechToTextCubit>()
                            .testModel(stateSymptoms.symptomsArray);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, route.suggestionsScreen);
                      }
                    },
                    child: GestureDetector(
                      onTap: () async {
                        print("clicked");
                        if (!isListening) {
                          var available = await speech.initialize(
                            onStatus: (status) {
                              if (status == 'notListening') {
                                print('Not listening');
                                context
                                    .read<SpeechToTextCubit>()
                                    .toggleListening(false);
                                context
                                    .read<SpeechToTextCubit>()
                                    .toggleText('Tap mic to speak');

                                successDialog(
                                  context: context,
                                  title: 'Confirm',
                                  success: true,
                                  focusNodes: true,
                                  onPressed: () {
                                    context.read<ExtractSymptomsBloc>().add(
                                        ExtractSymptoms(
                                            text: _symptomsController.text));
                                  },
                                  input: true,
                                  message: 'Do you want to send this message?',
                                );
                              }
                            },
                            onError: (error) {
                              Fluttertoast.showToast(msg: error.errorMsg);
                              context
                                  .read<SpeechToTextCubit>()
                                  .toggleListening(false);
                              context
                                  .read<SpeechToTextCubit>()
                                  .toggleText('Tap mic to speak');
                            },
                          );
                          if (available) {
                            context
                                .read<SpeechToTextCubit>()
                                .toggleListening(true);
                            context
                                .read<SpeechToTextCubit>()
                                .toggleText('Listening...');

                            speech.listen(
                              onResult: (value) {
                                context
                                    .read<SpeechToTextCubit>()
                                    .toggleMessage(value.recognizedWords);
                                print('after chagning after emitting');
                                print(state.controller.toString());
                              },
                            );
                          } else {
                            context.read<SpeechToTextCubit>().toggleMessage(
                                'Speech recognition not available');
                          }
                        } else {
                          speech.stop();
                          context
                              .read<SpeechToTextCubit>()
                              .toggleListening(false);
                          context
                              .read<SpeechToTextCubit>()
                              .toggleText('Tap mic to speak');
                        }
                      },
                      child: Image.asset('assets/images/mic 1.png',
                          width: size.width / 4, height: size.width / 3),
                    ),
                  ),
                ),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Istok Web',
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
