// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:diseases/constants/env.dart';
import 'package:http/http.dart' as http;

import 'base_extract_symptoms_repository.dart';

class ExtractSymptomsRepository extends BaseExtractSymptomsRepository {
  @override
  Future<List<List<dynamic>>> extractSymptoms({
    required String text,
  }) async {
    final response =
        await http.post(Uri.parse(Environment.EXTRACT_SYMPTOMS_URL),
            headers: {
              'Content-Type': 'application/json',
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NjRiMDJkZDQ3MDczNWU0Y2I4YmNhMSIsImVtYWlsIjoia2ltYXRyb2Npb3VzQGdtYWlsLmNvbSIsImlhdCI6MTcwMTEwMTA5MCwiZXhwIjoxNzAxMTAyODkwfQ.oFN7NE_9KMiw_Zcv3SUmQBfRodWxxY-Nmvz4KLEzoZc'
            },
            body: jsonEncode(
              {
                "text": text,
              },
            ));
    print(response.body);
    final responseData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final extractedSymptoms = responseData['extractedSymptoms'].keys.toList();
      final symptomsArray = (responseData['symptomArray'] ?? []);
      return [extractedSymptoms, symptomsArray];
    } else {
      throw Exception(responseData['message'] ??
          responseData['error'] ??
          'Failed to extract symptoms');
    }
  }
}
