// ignore_for_file: body_might_complete_normally_nullable
abstract class BaseExtractSymptomsRepository {
  Future<List<List<dynamic>>> extractSymptoms({
    required String text,
  }) async {
    return [];
  }
}
