import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Favoritos extends Table {
  TextColumn get titulo    => text()();
  TextColumn get imageUrl  => text()();

  @override
  Set<Column> get primaryKey => {titulo};
}

@DriftDatabase(tables: [Favoritos])

class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Favorito>> listarFavoritos() =>
      select(favoritos).get();

  Future<bool> isFavorito(String titulo) async {
    final resultado = await (select(favoritos)
          ..where((t) => t.titulo.equals(titulo)))
        .getSingleOrNull();
    return resultado != null;
  }

  Future<void> adicionarFavorito(String titulo, String imageUrl) =>
      into(favoritos).insertOnConflictUpdate(
        FavoritosCompanion.insert(titulo: titulo, imageUrl: imageUrl),
      );

  Future<void> removerFavorito(String titulo) =>
      (delete(favoritos)..where((t) => t.titulo.equals(titulo))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'favoritos.db'));
    return NativeDatabase.createInBackground(file);
  });
}