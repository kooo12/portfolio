class Skill {
  final String id;
  final String name;
  final String category;
  final int proficiency; // 1-100
  final String iconUrl;

  Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.proficiency,
    required this.iconUrl,
  });
}
