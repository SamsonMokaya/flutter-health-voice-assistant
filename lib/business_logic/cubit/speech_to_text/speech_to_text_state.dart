// ignore_for_file: non_constant_identifier_names

part of 'speech_to_text_cubit.dart';

class SpeechToTextState {
  final bool loading;
  final String text;
  final bool isListening;
  final String message;
  final TextEditingController controller;
  final List<Disease> diseases;

  SpeechToTextState({
    required this.loading,
    required this.text,
    required this.isListening,
    required this.message,
    required this.controller,
    required this.diseases,
  });

  factory SpeechToTextState.initial() {
    return SpeechToTextState(
      loading: false,
      text: 'Tap mic to speak',
      isListening: false,
      diseases: <Disease>[],
      controller: TextEditingController(),
      message: 'Greetings, what symptoms have been experiencing lately?',
    );
  }

  SpeechToTextState copyWith({
    bool? loading,
    String? text,
    bool? isListening,
    String? message,
    List<Disease>? diseases,
    TextEditingController? controller,
  }) {
    return SpeechToTextState(
      loading: loading ?? this.loading,
      text: text ?? this.text,
      controller: controller ?? this.controller,
      isListening: isListening ?? this.isListening,
      diseases: diseases ?? this.diseases,
      message: message ?? this.message,
    );
  }
}
