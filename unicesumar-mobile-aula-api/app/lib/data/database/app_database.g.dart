part of 'app_database.dart';

class $FavoritosTable extends Favoritos
    with TableInfo<$FavoritosTable, Favorito> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
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
  @override
  List<GeneratedColumn> get $columns => [titulo, imageUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favoritos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorito> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {titulo};
  @override
  Favorito map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorito(
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      )!,
    );
  }

  @override
  $FavoritosTable createAlias(String alias) {
    return $FavoritosTable(attachedDatabase, alias);
  }
}

class Favorito extends DataClass implements Insertable<Favorito> {
  final String titulo;
  final String imageUrl;
  const Favorito({required this.titulo, required this.imageUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['titulo'] = Variable<String>(titulo);
    map['image_url'] = Variable<String>(imageUrl);
    return map;
  }

  FavoritosCompanion toCompanion(bool nullToAbsent) {
    return FavoritosCompanion(titulo: Value(titulo), imageUrl: Value(imageUrl));
  }

  factory Favorito.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorito(
      titulo: serializer.fromJson<String>(json['titulo']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'titulo': serializer.toJson<String>(titulo),
      'imageUrl': serializer.toJson<String>(imageUrl),
    };
  }

  Favorito copyWith({String? titulo, String? imageUrl}) => Favorito(
    titulo: titulo ?? this.titulo,
    imageUrl: imageUrl ?? this.imageUrl,
  );
  Favorito copyWithCompanion(FavoritosCompanion data) {
    return Favorito(
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorito(')
          ..write('titulo: $titulo, ')
          ..write('imageUrl: $imageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(titulo, imageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorito &&
          other.titulo == this.titulo &&
          other.imageUrl == this.imageUrl);
}

class FavoritosCompanion extends UpdateCompanion<Favorito> {
  final Value<String> titulo;
  final Value<String> imageUrl;
  final Value<int> rowid;
  const FavoritosCompanion({
    this.titulo = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoritosCompanion.insert({
    required String titulo,
    required String imageUrl,
    this.rowid = const Value.absent(),
  }) : titulo = Value(titulo),
       imageUrl = Value(imageUrl);
  static Insertable<Favorito> custom({
    Expression<String>? titulo,
    Expression<String>? imageUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (titulo != null) 'titulo': titulo,
      if (imageUrl != null) 'image_url': imageUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoritosCompanion copyWith({
    Value<String>? titulo,
    Value<String>? imageUrl,
    Value<int>? rowid,
  }) {
    return FavoritosCompanion(
      titulo: titulo ?? this.titulo,
      imageUrl: imageUrl ?? this.imageUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritosCompanion(')
          ..write('titulo: $titulo, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoritosTable favoritos = $FavoritosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoritos];
}

typedef $$FavoritosTableCreateCompanionBuilder =
    FavoritosCompanion Function({
      required String titulo,
      required String imageUrl,
      Value<int> rowid,
    });
typedef $$FavoritosTableUpdateCompanionBuilder =
    FavoritosCompanion Function({
      Value<String> titulo,
      Value<String> imageUrl,
      Value<int> rowid,
    });

class $$FavoritosTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritosTable> {
  $$FavoritosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritosTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritosTable> {
  $$FavoritosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritosTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritosTable> {
  $$FavoritosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);
}

class $$FavoritosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritosTable,
          Favorito,
          $$FavoritosTableFilterComposer,
          $$FavoritosTableOrderingComposer,
          $$FavoritosTableAnnotationComposer,
          $$FavoritosTableCreateCompanionBuilder,
          $$FavoritosTableUpdateCompanionBuilder,
          (Favorito, BaseReferences<_$AppDatabase, $FavoritosTable, Favorito>),
          Favorito,
          PrefetchHooks Function()
        > {
  $$FavoritosTableTableManager(_$AppDatabase db, $FavoritosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> titulo = const Value.absent(),
                Value<String> imageUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoritosCompanion(
                titulo: titulo,
                imageUrl: imageUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String titulo,
                required String imageUrl,
                Value<int> rowid = const Value.absent(),
              }) => FavoritosCompanion.insert(
                titulo: titulo,
                imageUrl: imageUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritosTable,
      Favorito,
      $$FavoritosTableFilterComposer,
      $$FavoritosTableOrderingComposer,
      $$FavoritosTableAnnotationComposer,
      $$FavoritosTableCreateCompanionBuilder,
      $$FavoritosTableUpdateCompanionBuilder,
      (Favorito, BaseReferences<_$AppDatabase, $FavoritosTable, Favorito>),
      Favorito,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoritosTableTableManager get favoritos =>
      $$FavoritosTableTableManager(_db, _db.favoritos);
}
