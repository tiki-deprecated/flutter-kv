import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'model.dart';
import 'repository.dart';

class Service {
  final Repository _repository;

  Service(Database database, String table)
      : _repository = Repository(database, table);

  Future<void> init() => _repository.createTable();

  Future<Model?> getByKey(String key) async => _repository.getByKey(key);

  Future<Model?> upsert(String key, String value) async {
    Model? data = await getByKey(key);
    Model dataToInsert =
        Model(id: data?.id, key: data?.key ?? key, value: value);
    return data == null
        ? await _repository.insert(dataToInsert)
        : await _repository.update(dataToInsert);
  }

  Future<Model?> newOrFail(String key, String value) async {
    Model? data = await getByKey(key);
    if (data != null) throw StateError('The key $key already exists');
    Model dataToInsert = Model(id: null, key: key, value: value);
    return await _repository.insert(dataToInsert);
  }

  Future<void> delete(String key) => _repository.deleteByKey(key);

  Future<void> deleteAllData() => _repository.deleteAll();
}
