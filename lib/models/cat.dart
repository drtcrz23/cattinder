class Cat {
  final String id;
  final String imageUrl;
  final String breedName;
  final String? description;
  final String? temperament;
  final String? origin;

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    this.description,
    this.temperament,
    this.origin,
  });

  factory Cat.fromJson(Map<String, dynamic> json) {
    return Cat(
      id: json['id'],
      imageUrl: json['url'],
      breedName: json['breeds']?[0]['name'] ?? 'Unknown breed',
      description: json['breeds']?[0]['description'],
      temperament: json['breeds']?[0]['temperament'],
      origin: json['breeds']?[0]['origin'],
    );
  }
}