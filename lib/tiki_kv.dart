import 'package:sqflite_sqlcipher/sqflite.dart';

import 'src/model.dart';
import 'src/service.dart';

class TikiKv {
  final Service _service;

  TikiKv({required Database database, String table = 'tiki_kv'})
      : _service = Service(database, table);

  Future<TikiKv> init() async {
    await _service.init();
    return this;
  }

  Future<String?> create(String key, String value) async {
    Model? model = await _service.newOrFail(key, value);
    return model?.value;
  }

  Future<String?> read(String key) async {
    Model? model = await _service.getByKey(key);
    return model?.value;
  }

  Future<String?> upsert(String key, String value) async {
    Model? model = await _service.upsert(key, value);
    return model?.value;
  }

  Future<void> delete(String key) async => await _service.delete(key);

  Future<void> deleteAll() async => await _service.deleteAllData();
}
