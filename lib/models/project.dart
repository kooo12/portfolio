class Project {
  final String id;
  final String title;
  final String description;
  final List<String> responsibilities;
  final List<String> coreFeatures;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String category;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.responsibilities,
    required this.coreFeatures,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    required this.category,
  });
}
