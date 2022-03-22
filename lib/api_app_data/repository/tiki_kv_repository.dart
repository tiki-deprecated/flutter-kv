import 'package:sqflite_sqlcipher/sqlite_api.dart';

import '../model/tiki_kv_model.dart';

class TikiKVRepository {
  static const String _table = 'app_data';
  final Database _database;

  TikiKVRepository(this._database);

  Future<TikiKVModel?> insert(TikiKVModel data) async {
    int dataId = await _database.insert(_table, data.toJson());
    data.id = dataId;
    return data;
  }

  Future<TikiKVModel> update(TikiKVModel data) async {
    await _database.update(
      _table,
      data.toJson(),
      where: 'id = ?',
      whereArgs: [data.id],
    );
    return data;
  }

  Future<void> delete(int id) async {
    await _database.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<TikiKVModel?> getById(int id) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "id = ?", whereArgs: [id]);
    if (rows.isEmpty) return null;
    return TikiKVModel.fromJson(rows[0]);
  }

  Future<TikiKVModel?> getByKey(String key) async {
    final List<Map<String, Object?>> rows =
        await _database.query(_table, where: "key = ?", whereArgs: [key]);
    if (rows.isEmpty) return null;
    return TikiKVModel.fromJson(rows[0]);
  }

  deleteByKey(String key) async {
    await _database.delete(_table, where: "key = ?", whereArgs: [key]);
  }
}
