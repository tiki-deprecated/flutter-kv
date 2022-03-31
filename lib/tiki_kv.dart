import 'package:sqflite_sqlcipher/sqflite.dart';

import 'api_app_data/model/tiki_kv_model.dart';
import 'api_app_data/tiki_kv_service.dart';

class TikiKv {
  final TikiKVService _service;

  TikiKv({required Database database})
      : _service = TikiKVService(database: database);

  Future<TikiKVModel?> create(String key, String value) async =>
      await _service.newOrFail(key, value);

  Future<TikiKVModel?> read(String key) async => await _service.getByKey(key);

  Future<TikiKVModel?> upsert(String key, String value) async =>
      await _service.upsert(key, value);

  Future<void> delete(String key) async => await _service.delete(key);

  Future<void> deleteAllData() async => await _service.deleteAllData();

}
