part of 'extract_symptoms_bloc.dart';

abstract class ExtractSymptomsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ExtractSymptoms extends ExtractSymptomsEvent {
  final String text;

  ExtractSymptoms({
    required this.text,
  });
  @override
  List<Object> get props => [text];
}
