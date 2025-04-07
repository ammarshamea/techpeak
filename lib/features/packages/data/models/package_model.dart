class PackageModel {
  final String name;
  final String size;
  final String price;
  final String duration;
  final List<String> features;
  final bool isPopular;

  PackageModel({
    required this.name,
    required this.size,
    required this.price,
    required this.duration,
    required this.features,
    this.isPopular = false,
  });
} 