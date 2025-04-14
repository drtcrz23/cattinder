class Cat {

  Cat({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    this.description,
    this.temperament,
    this.origin,
    this.likedAt,
  });
  final String id;
  final String imageUrl;
  final String breedName;
  final String? description;
  final String? temperament;
  final String? origin;
  final DateTime? likedAt;

  Cat copyWith({
    String? id,
    String? imageUrl,
    String? breedName,
    String? description,
    String? temperament,
    String? origin,
    DateTime? likedAt,
  }) {
    return Cat(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breedName: breedName ?? this.breedName,
      description: description ?? this.description,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      likedAt: likedAt ?? this.likedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cat && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
