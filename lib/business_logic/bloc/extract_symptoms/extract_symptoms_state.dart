part of 'extract_symptoms_bloc.dart';

abstract class ExtractSymptomsState extends Equatable {
  const ExtractSymptomsState();

  @override
  List<Object> get props => [];
}

class ExtractSymptomsLoading extends ExtractSymptomsState {}

class ExtractSymptomsInitial extends ExtractSymptomsState {}

class ExtractSymptomsSuccess extends ExtractSymptomsState {
  final List<String> extractedSymptoms;
  final List<int> symptomsArray;

  const ExtractSymptomsSuccess(
      {required this.extractedSymptoms, required this.symptomsArray});
  @override
  List<Object> get props => [extractedSymptoms, symptomsArray];
}

class ExtractSymptomsError extends ExtractSymptomsState {
  final String errorMessage;

  const ExtractSymptomsError(
      {required String action, required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
