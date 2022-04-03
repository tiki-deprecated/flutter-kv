import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'model.dart';

class Repository {
  final Database _database;
  final String _table;

  Repository(this._database, this._table);

  Future<void> createTable() =>
      _database.execute('CREATE TABLE IF NOT EXISTS $_table('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'key TEXT NOT NULL, '
          'value TEXT NOT NULL);');

  Future<Model?> insert(Model data) async {
    int dataId = await _database.insert(_table, data.toJson());
    data.id = dataId;
    return data;
  }

  Future<Model> update(Model data) async {
    await _database.update(
      _table,
      data.toJson(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
    return data;
  }

  Future<Model?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return Model.fromJson(rows[0]);
  }

  Future<Model?> getByKey(String key) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "key = ?", whereArgs: [key]);
    if (rows.isEmpty) return null;
    return Model.fromJson(rows[0]);
  }

  Future<void> deleteById(int id) => _database.delete(
        _table,
        where: 'id = ?',
        whereArgs: [id],
      );

  Future<void> deleteByKey(String key) =>
      _database.delete(_table, where: "key = ?", whereArgs: [key]);

  Future<void> deleteAll() => _database.delete(_table);
}
