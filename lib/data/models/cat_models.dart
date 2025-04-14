import '../../domain/entities/cat.dart';

class CatModel extends Cat {
  CatModel({
    required String id,
    required String imageUrl,
    required String breedName,
    String? description,
    String? temperament,
    String? origin,
  }) : super(
    id: id,
    imageUrl: imageUrl,
    breedName: breedName,
    description: description,
    temperament: temperament,
    origin: origin,
  );

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
