// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CachedCatsTable extends CachedCats
    with TableInfo<$CachedCatsTable, CachedCat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedCatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedNameMeta = const VerificationMeta(
    'breedName',
  );
  @override
  late final GeneratedColumn<String> breedName = GeneratedColumn<String>(
    'breed_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperamentMeta = const VerificationMeta(
    'temperament',
  );
  @override
  late final GeneratedColumn<String> temperament = GeneratedColumn<String>(
    'temperament',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageUrl,
    breedName,
    description,
    temperament,
    origin,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_cats';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedCat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('breed_name')) {
      context.handle(
        _breedNameMeta,
        breedName.isAcceptableOrUnknown(data['breed_name']!, _breedNameMeta),
      );
    } else if (isInserting) {
      context.missing(_breedNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('temperament')) {
      context.handle(
        _temperamentMeta,
        temperament.isAcceptableOrUnknown(
          data['temperament']!,
          _temperamentMeta,
        ),
      );
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedCat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedCat(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      breedName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}breed_name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      temperament: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}temperament'],
      ),
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      ),
      cachedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}cached_at'],
          )!,
    );
  }

  @override
  $CachedCatsTable createAlias(String alias) {
    return $CachedCatsTable(attachedDatabase, alias);
  }
}

class CachedCat extends DataClass implements Insertable<CachedCat> {
  final String id;
  final String imageUrl;
  final String breedName;
  final String? description;
  final String? temperament;
  final String? origin;
  final DateTime cachedAt;
  const CachedCat({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    this.description,
    this.temperament,
    this.origin,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['breed_name'] = Variable<String>(breedName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || temperament != null) {
      map['temperament'] = Variable<String>(temperament);
    }
    if (!nullToAbsent || origin != null) {
      map['origin'] = Variable<String>(origin);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedCatsCompanion toCompanion(bool nullToAbsent) {
    return CachedCatsCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      breedName: Value(breedName),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      temperament:
          temperament == null && nullToAbsent
              ? const Value.absent()
              : Value(temperament),
      origin:
          origin == null && nullToAbsent ? const Value.absent() : Value(origin),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedCat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedCat(
      id: serializer.fromJson<String>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      breedName: serializer.fromJson<String>(json['breedName']),
      description: serializer.fromJson<String?>(json['description']),
      temperament: serializer.fromJson<String?>(json['temperament']),
      origin: serializer.fromJson<String?>(json['origin']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'breedName': serializer.toJson<String>(breedName),
      'description': serializer.toJson<String?>(description),
      'temperament': serializer.toJson<String?>(temperament),
      'origin': serializer.toJson<String?>(origin),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedCat copyWith({
    String? id,
    String? imageUrl,
    String? breedName,
    Value<String?> description = const Value.absent(),
    Value<String?> temperament = const Value.absent(),
    Value<String?> origin = const Value.absent(),
    DateTime? cachedAt,
  }) => CachedCat(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    breedName: breedName ?? this.breedName,
    description: description.present ? description.value : this.description,
    temperament: temperament.present ? temperament.value : this.temperament,
    origin: origin.present ? origin.value : this.origin,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedCat copyWithCompanion(CachedCatsCompanion data) {
    return CachedCat(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      breedName: data.breedName.present ? data.breedName.value : this.breedName,
      description:
          data.description.present ? data.description.value : this.description,
      temperament:
          data.temperament.present ? data.temperament.value : this.temperament,
      origin: data.origin.present ? data.origin.value : this.origin,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedCat(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breedName: $breedName, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    imageUrl,
    breedName,
    description,
    temperament,
    origin,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedCat &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.breedName == this.breedName &&
          other.description == this.description &&
          other.temperament == this.temperament &&
          other.origin == this.origin &&
          other.cachedAt == this.cachedAt);
}

class CachedCatsCompanion extends UpdateCompanion<CachedCat> {
  final Value<String> id;
  final Value<String> imageUrl;
  final Value<String> breedName;
  final Value<String?> description;
  final Value<String?> temperament;
  final Value<String?> origin;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedCatsCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.breedName = const Value.absent(),
    this.description = const Value.absent(),
    this.temperament = const Value.absent(),
    this.origin = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedCatsCompanion.insert({
    required String id,
    required String imageUrl,
    required String breedName,
    this.description = const Value.absent(),
    this.temperament = const Value.absent(),
    this.origin = const Value.absent(),
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imageUrl = Value(imageUrl),
       breedName = Value(breedName),
       cachedAt = Value(cachedAt);
  static Insertable<CachedCat> custom({
    Expression<String>? id,
    Expression<String>? imageUrl,
    Expression<String>? breedName,
    Expression<String>? description,
    Expression<String>? temperament,
    Expression<String>? origin,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (breedName != null) 'breed_name': breedName,
      if (description != null) 'description': description,
      if (temperament != null) 'temperament': temperament,
      if (origin != null) 'origin': origin,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedCatsCompanion copyWith({
    Value<String>? id,
    Value<String>? imageUrl,
    Value<String>? breedName,
    Value<String?>? description,
    Value<String?>? temperament,
    Value<String?>? origin,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedCatsCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breedName: breedName ?? this.breedName,
      description: description ?? this.description,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (breedName.present) {
      map['breed_name'] = Variable<String>(breedName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (temperament.present) {
      map['temperament'] = Variable<String>(temperament.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedCatsCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breedName: $breedName, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LikedCatsTable extends LikedCats
    with TableInfo<$LikedCatsTable, LikedCat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LikedCatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breedNameMeta = const VerificationMeta(
    'breedName',
  );
  @override
  late final GeneratedColumn<String> breedName = GeneratedColumn<String>(
    'breed_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temperamentMeta = const VerificationMeta(
    'temperament',
  );
  @override
  late final GeneratedColumn<String> temperament = GeneratedColumn<String>(
    'temperament',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
    'origin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _likedAtMeta = const VerificationMeta(
    'likedAt',
  );
  @override
  late final GeneratedColumn<DateTime> likedAt = GeneratedColumn<DateTime>(
    'liked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    imageUrl,
    breedName,
    description,
    temperament,
    origin,
    likedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'liked_cats';
  @override
  VerificationContext validateIntegrity(
    Insertable<LikedCat> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('breed_name')) {
      context.handle(
        _breedNameMeta,
        breedName.isAcceptableOrUnknown(data['breed_name']!, _breedNameMeta),
      );
    } else if (isInserting) {
      context.missing(_breedNameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('temperament')) {
      context.handle(
        _temperamentMeta,
        temperament.isAcceptableOrUnknown(
          data['temperament']!,
          _temperamentMeta,
        ),
      );
    }
    if (data.containsKey('origin')) {
      context.handle(
        _originMeta,
        origin.isAcceptableOrUnknown(data['origin']!, _originMeta),
      );
    }
    if (data.containsKey('liked_at')) {
      context.handle(
        _likedAtMeta,
        likedAt.isAcceptableOrUnknown(data['liked_at']!, _likedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_likedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LikedCat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LikedCat(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      imageUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image_url'],
          )!,
      breedName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}breed_name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      temperament: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}temperament'],
      ),
      origin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}origin'],
      ),
      likedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}liked_at'],
          )!,
    );
  }

  @override
  $LikedCatsTable createAlias(String alias) {
    return $LikedCatsTable(attachedDatabase, alias);
  }
}

class LikedCat extends DataClass implements Insertable<LikedCat> {
  final String id;
  final String imageUrl;
  final String breedName;
  final String? description;
  final String? temperament;
  final String? origin;
  final DateTime likedAt;
  const LikedCat({
    required this.id,
    required this.imageUrl,
    required this.breedName,
    this.description,
    this.temperament,
    this.origin,
    required this.likedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['image_url'] = Variable<String>(imageUrl);
    map['breed_name'] = Variable<String>(breedName);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || temperament != null) {
      map['temperament'] = Variable<String>(temperament);
    }
    if (!nullToAbsent || origin != null) {
      map['origin'] = Variable<String>(origin);
    }
    map['liked_at'] = Variable<DateTime>(likedAt);
    return map;
  }

  LikedCatsCompanion toCompanion(bool nullToAbsent) {
    return LikedCatsCompanion(
      id: Value(id),
      imageUrl: Value(imageUrl),
      breedName: Value(breedName),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      temperament:
          temperament == null && nullToAbsent
              ? const Value.absent()
              : Value(temperament),
      origin:
          origin == null && nullToAbsent ? const Value.absent() : Value(origin),
      likedAt: Value(likedAt),
    );
  }

  factory LikedCat.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LikedCat(
      id: serializer.fromJson<String>(json['id']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      breedName: serializer.fromJson<String>(json['breedName']),
      description: serializer.fromJson<String?>(json['description']),
      temperament: serializer.fromJson<String?>(json['temperament']),
      origin: serializer.fromJson<String?>(json['origin']),
      likedAt: serializer.fromJson<DateTime>(json['likedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'breedName': serializer.toJson<String>(breedName),
      'description': serializer.toJson<String?>(description),
      'temperament': serializer.toJson<String?>(temperament),
      'origin': serializer.toJson<String?>(origin),
      'likedAt': serializer.toJson<DateTime>(likedAt),
    };
  }

  LikedCat copyWith({
    String? id,
    String? imageUrl,
    String? breedName,
    Value<String?> description = const Value.absent(),
    Value<String?> temperament = const Value.absent(),
    Value<String?> origin = const Value.absent(),
    DateTime? likedAt,
  }) => LikedCat(
    id: id ?? this.id,
    imageUrl: imageUrl ?? this.imageUrl,
    breedName: breedName ?? this.breedName,
    description: description.present ? description.value : this.description,
    temperament: temperament.present ? temperament.value : this.temperament,
    origin: origin.present ? origin.value : this.origin,
    likedAt: likedAt ?? this.likedAt,
  );
  LikedCat copyWithCompanion(LikedCatsCompanion data) {
    return LikedCat(
      id: data.id.present ? data.id.value : this.id,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      breedName: data.breedName.present ? data.breedName.value : this.breedName,
      description:
          data.description.present ? data.description.value : this.description,
      temperament:
          data.temperament.present ? data.temperament.value : this.temperament,
      origin: data.origin.present ? data.origin.value : this.origin,
      likedAt: data.likedAt.present ? data.likedAt.value : this.likedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LikedCat(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breedName: $breedName, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('likedAt: $likedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    imageUrl,
    breedName,
    description,
    temperament,
    origin,
    likedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LikedCat &&
          other.id == this.id &&
          other.imageUrl == this.imageUrl &&
          other.breedName == this.breedName &&
          other.description == this.description &&
          other.temperament == this.temperament &&
          other.origin == this.origin &&
          other.likedAt == this.likedAt);
}

class LikedCatsCompanion extends UpdateCompanion<LikedCat> {
  final Value<String> id;
  final Value<String> imageUrl;
  final Value<String> breedName;
  final Value<String?> description;
  final Value<String?> temperament;
  final Value<String?> origin;
  final Value<DateTime> likedAt;
  final Value<int> rowid;
  const LikedCatsCompanion({
    this.id = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.breedName = const Value.absent(),
    this.description = const Value.absent(),
    this.temperament = const Value.absent(),
    this.origin = const Value.absent(),
    this.likedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LikedCatsCompanion.insert({
    required String id,
    required String imageUrl,
    required String breedName,
    this.description = const Value.absent(),
    this.temperament = const Value.absent(),
    this.origin = const Value.absent(),
    required DateTime likedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       imageUrl = Value(imageUrl),
       breedName = Value(breedName),
       likedAt = Value(likedAt);
  static Insertable<LikedCat> custom({
    Expression<String>? id,
    Expression<String>? imageUrl,
    Expression<String>? breedName,
    Expression<String>? description,
    Expression<String>? temperament,
    Expression<String>? origin,
    Expression<DateTime>? likedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imageUrl != null) 'image_url': imageUrl,
      if (breedName != null) 'breed_name': breedName,
      if (description != null) 'description': description,
      if (temperament != null) 'temperament': temperament,
      if (origin != null) 'origin': origin,
      if (likedAt != null) 'liked_at': likedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LikedCatsCompanion copyWith({
    Value<String>? id,
    Value<String>? imageUrl,
    Value<String>? breedName,
    Value<String?>? description,
    Value<String?>? temperament,
    Value<String?>? origin,
    Value<DateTime>? likedAt,
    Value<int>? rowid,
  }) {
    return LikedCatsCompanion(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      breedName: breedName ?? this.breedName,
      description: description ?? this.description,
      temperament: temperament ?? this.temperament,
      origin: origin ?? this.origin,
      likedAt: likedAt ?? this.likedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (breedName.present) {
      map['breed_name'] = Variable<String>(breedName.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (temperament.present) {
      map['temperament'] = Variable<String>(temperament.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (likedAt.present) {
      map['liked_at'] = Variable<DateTime>(likedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LikedCatsCompanion(')
          ..write('id: $id, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('breedName: $breedName, ')
          ..write('description: $description, ')
          ..write('temperament: $temperament, ')
          ..write('origin: $origin, ')
          ..write('likedAt: $likedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CachedCatsTable cachedCats = $CachedCatsTable(this);
  late final $LikedCatsTable likedCats = $LikedCatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [cachedCats, likedCats];
}

typedef $$CachedCatsTableCreateCompanionBuilder =
    CachedCatsCompanion Function({
      required String id,
      required String imageUrl,
      required String breedName,
      Value<String?> description,
      Value<String?> temperament,
      Value<String?> origin,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$CachedCatsTableUpdateCompanionBuilder =
    CachedCatsCompanion Function({
      Value<String> id,
      Value<String> imageUrl,
      Value<String> breedName,
      Value<String?> description,
      Value<String?> temperament,
      Value<String?> origin,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$CachedCatsTableFilterComposer
    extends Composer<_$AppDatabase, $CachedCatsTable> {
  $$CachedCatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breedName => $composableBuilder(
    column: $table.breedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedCatsTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedCatsTable> {
  $$CachedCatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breedName => $composableBuilder(
    column: $table.breedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedCatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedCatsTable> {
  $$CachedCatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get breedName =>
      $composableBuilder(column: $table.breedName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$CachedCatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedCatsTable,
          CachedCat,
          $$CachedCatsTableFilterComposer,
          $$CachedCatsTableOrderingComposer,
          $$CachedCatsTableAnnotationComposer,
          $$CachedCatsTableCreateCompanionBuilder,
          $$CachedCatsTableUpdateCompanionBuilder,
          (
            CachedCat,
            BaseReferences<_$AppDatabase, $CachedCatsTable, CachedCat>,
          ),
          CachedCat,
          PrefetchHooks Function()
        > {
  $$CachedCatsTableTableManager(_$AppDatabase db, $CachedCatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CachedCatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CachedCatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CachedCatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> breedName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> temperament = const Value.absent(),
                Value<String?> origin = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedCatsCompanion(
                id: id,
                imageUrl: imageUrl,
                breedName: breedName,
                description: description,
                temperament: temperament,
                origin: origin,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imageUrl,
                required String breedName,
                Value<String?> description = const Value.absent(),
                Value<String?> temperament = const Value.absent(),
                Value<String?> origin = const Value.absent(),
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedCatsCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                breedName: breedName,
                description: description,
                temperament: temperament,
                origin: origin,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedCatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedCatsTable,
      CachedCat,
      $$CachedCatsTableFilterComposer,
      $$CachedCatsTableOrderingComposer,
      $$CachedCatsTableAnnotationComposer,
      $$CachedCatsTableCreateCompanionBuilder,
      $$CachedCatsTableUpdateCompanionBuilder,
      (CachedCat, BaseReferences<_$AppDatabase, $CachedCatsTable, CachedCat>),
      CachedCat,
      PrefetchHooks Function()
    >;
typedef $$LikedCatsTableCreateCompanionBuilder =
    LikedCatsCompanion Function({
      required String id,
      required String imageUrl,
      required String breedName,
      Value<String?> description,
      Value<String?> temperament,
      Value<String?> origin,
      required DateTime likedAt,
      Value<int> rowid,
    });
typedef $$LikedCatsTableUpdateCompanionBuilder =
    LikedCatsCompanion Function({
      Value<String> id,
      Value<String> imageUrl,
      Value<String> breedName,
      Value<String?> description,
      Value<String?> temperament,
      Value<String?> origin,
      Value<DateTime> likedAt,
      Value<int> rowid,
    });

class $$LikedCatsTableFilterComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breedName => $composableBuilder(
    column: $table.breedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LikedCatsTableOrderingComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breedName => $composableBuilder(
    column: $table.breedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get likedAt => $composableBuilder(
    column: $table.likedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LikedCatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LikedCatsTable> {
  $$LikedCatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get breedName =>
      $composableBuilder(column: $table.breedName, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get temperament => $composableBuilder(
    column: $table.temperament,
    builder: (column) => column,
  );

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<DateTime> get likedAt =>
      $composableBuilder(column: $table.likedAt, builder: (column) => column);
}

class $$LikedCatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LikedCatsTable,
          LikedCat,
          $$LikedCatsTableFilterComposer,
          $$LikedCatsTableOrderingComposer,
          $$LikedCatsTableAnnotationComposer,
          $$LikedCatsTableCreateCompanionBuilder,
          $$LikedCatsTableUpdateCompanionBuilder,
          (LikedCat, BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCat>),
          LikedCat,
          PrefetchHooks Function()
        > {
  $$LikedCatsTableTableManager(_$AppDatabase db, $LikedCatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LikedCatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LikedCatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LikedCatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<String> breedName = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> temperament = const Value.absent(),
                Value<String?> origin = const Value.absent(),
                Value<DateTime> likedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsCompanion(
                id: id,
                imageUrl: imageUrl,
                breedName: breedName,
                description: description,
                temperament: temperament,
                origin: origin,
                likedAt: likedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String imageUrl,
                required String breedName,
                Value<String?> description = const Value.absent(),
                Value<String?> temperament = const Value.absent(),
                Value<String?> origin = const Value.absent(),
                required DateTime likedAt,
                Value<int> rowid = const Value.absent(),
              }) => LikedCatsCompanion.insert(
                id: id,
                imageUrl: imageUrl,
                breedName: breedName,
                description: description,
                temperament: temperament,
                origin: origin,
                likedAt: likedAt,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LikedCatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LikedCatsTable,
      LikedCat,
      $$LikedCatsTableFilterComposer,
      $$LikedCatsTableOrderingComposer,
      $$LikedCatsTableAnnotationComposer,
      $$LikedCatsTableCreateCompanionBuilder,
      $$LikedCatsTableUpdateCompanionBuilder,
      (LikedCat, BaseReferences<_$AppDatabase, $LikedCatsTable, LikedCat>),
      LikedCat,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CachedCatsTableTableManager get cachedCats =>
      $$CachedCatsTableTableManager(_db, _db.cachedCats);
  $$LikedCatsTableTableManager get likedCats =>
      $$LikedCatsTableTableManager(_db, _db.likedCats);
}
