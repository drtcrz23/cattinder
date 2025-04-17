import '../../domain/entities/cat.dart';

class CatModel extends Cat {
  CatModel({
    required super.id,
    required super.imageUrl,
    required super.breedName,
    super.description,
    super.temperament,
    super.origin,
  });

  factory CatModel.fromJson(Map<String, dynamic> json) {
    final breed = json['breeds']?[0];
    return CatModel(
      id: json['id'],
      imageUrl: json['url'],
      breedName: breed?['name'] ?? 'Unknown breed',
      description: breed?['description'],
      temperament: breed?['temperament'],
      origin: breed?['origin'],
    );
  }
}
