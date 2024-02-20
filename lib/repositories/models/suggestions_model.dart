// create the suggestions model
class Suggestion {
  final String title;
  final double accuracy;
  final String description;

  const Suggestion({
    required this.title,
    required this.accuracy,
    required this.description,
  });
}
