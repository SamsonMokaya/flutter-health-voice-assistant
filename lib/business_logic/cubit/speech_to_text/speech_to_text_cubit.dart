import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
part 'speech_to_text_state.dart';

class SpeechToTextCubit extends Cubit<SpeechToTextState> {
  SpeechToTextCubit() : super(SpeechToTextState.initial());

  void toggleLoading(bool loading) {
    emit(state.copyWith(loading: loading));
  }

  void toggleListening(bool isListening) {
    emit(state.copyWith(isListening: isListening));
  }

  void toggleText(String text) {
    emit(state.copyWith(text: text));
  }

  void toggleMessage(String message) {
    state.controller.text = message;
    print('after chagning before emitting');
    print(state.controller.toString());
    emit(state.copyWith(message: message, controller: state.controller));
  }

  void testModel(List<int> dataList) async {
    try {
      // Define the desired shape
      List<int> desiredShape = [
        1,
        132
      ]; // Adjust the shape to match your model's input shape

      var classMappings = {
        15: 'Fungal infection',
        4: 'Allergy',
        16: 'GERD',
        9: 'Chronic cholestasis',
        14: 'Drug Reaction',
        33: 'Peptic ulcer diseae',
        1: 'AIDS',
        12: 'Diabetes ',
        17: 'Gastroenteritis',
        6: 'Bronchial Asthma',
        23: 'Hypertension ',
        30: 'Migraine',
        7: 'Cervical spondylosis',
        32: 'Paralysis (brain hemorrhage)',
        28: 'Jaundice',
        29: 'Malaria',
        8: 'Chicken pox',
        11: 'Dengue',
        37: 'Typhoid',
        40: 'hepatitis A',
        19: 'Hepatitis B',
        20: 'Hepatitis C',
        21: 'Hepatitis D',
        22: 'Hepatitis E',
        3: 'Alcoholic hepatitis',
        36: 'Tuberculosis',
        10: 'Common Cold',
        34: 'Pneumonia',
        13: 'Dimorphic hemmorhoids(piles)',
        18: 'Heart attack',
        39: 'Varicose veins',
        26: 'Hypothyroidism',
        24: 'Hyperthyroidism',
        25: 'Hypoglycemia',
        31: 'Osteoarthristis',
        5: 'Arthritis',
        0: '(vertigo) Paroymsal  Positional Vertigo',
        2: 'Acne',
        38: 'Urinary tract infection',
        35: 'Psoriasis',
        27: 'Impetigo'
      };

      // Convert the list to a 2D array with the desired shape
      List<List<int>> inputArray = [];
      int index = 0;
      for (int i = 0; i < desiredShape[0]; i++) {
        List<int> row = [];
        for (int j = 0; j < desiredShape[1]; j++) {
          row.add(dataList[index]);
          index++;
        }
        inputArray.add(row);
      }

      // Load the model
      final interpreter =
          await tfl.Interpreter.fromAsset('assets/model.tflite');

      // Define input and output tensors
      var input = inputArray.expand((element) => element).toList();
      var output = List.filled(1 * 41, 0).reshape([1, 41]); // Adjust the shape

      // Run inference
      interpreter.runForMultipleInputs([input], {0: output});

      List<double> predictions = output[0];

      // Create a list of tuples containing index and percentage
      var percentageTuples = List.generate(
          predictions.length, (index) => Tuple2(index, predictions[index]));

      // Sort the list of tuples in descending order based on the percentage
      percentageTuples.sort((a, b) => b.item2.compareTo(a.item2));

      // Get the top 4 percentages
      var top4Percentages = percentageTuples.take(4);

      // Print the top 4 predictions and their corresponding percentages
      List<Disease> diseases = [];
      for (var entry in top4Percentages) {
        var index = entry.item1;
        var percentage = entry.item2 * 100;
        var disease = classMappings[index];
        diseases.add(Disease(name: disease.toString(), percentage: percentage));
        print('$disease: ${percentage.toStringAsFixed(2)}%');
      }
      emit(state.copyWith(diseases: diseases));

      // Close the interpreter when done
      interpreter.close();
    } catch (e) {
      print('Error running the model: $e');
    }
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}

class Disease {
  final String name;
  final double percentage;

  Disease({required this.name, required this.percentage});
}
