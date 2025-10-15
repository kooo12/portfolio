class Experience {
  final String id;
  final String company;
  final String position;
  final String duration;
  final String description;
  final List<String> achievements;
  final String? logoUrl;

  Experience({
    required this.id,
    required this.company,
    required this.position,
    required this.duration,
    required this.description,
    required this.achievements,
    this.logoUrl,
  });
}
