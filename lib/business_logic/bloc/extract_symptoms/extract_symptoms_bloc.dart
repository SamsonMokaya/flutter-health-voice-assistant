import 'package:diseases/repositories/extract_symptoms_repository/extract_symptoms_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'extract_symptoms_event.dart';
part 'extract_symptoms_state.dart';

class ExtractSymptomsBloc
    extends Bloc<ExtractSymptomsEvent, ExtractSymptomsState> {
  final ExtractSymptomsRepository _extractSymptomsRepository;

  ExtractSymptomsBloc(
      {required ExtractSymptomsRepository extractSymptomsRepository})
      : _extractSymptomsRepository = extractSymptomsRepository,
        super(ExtractSymptomsInitial()) {
    on<ExtractSymptoms>(_onExtractSymptoms);
  }

  Future<void> _onExtractSymptoms(
      ExtractSymptoms event, Emitter<ExtractSymptomsState> emit) async {
    emit(ExtractSymptomsLoading());
    try {
      print(event.text);
      final List<List<dynamic>> symptoms =
          await _extractSymptomsRepository.extractSymptoms(
        text: event.text,
      );

      emit(ExtractSymptomsSuccess(
        extractedSymptoms: (symptoms[0]).map((item) => item as String).toList(),
        symptomsArray: (symptoms[1]).map((item) => item as int).toList(),
      ));
    } catch (e) {
      String errorMessage = e.toString().replaceAll('Exception:', '');
      emit(
          ExtractSymptomsError(errorMessage: errorMessage, action: 'register'));
    }
  }
}
