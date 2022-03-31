import 'package:sqflite_sqlcipher/sqlite_api.dart';

import 'model/tiki_kv_model.dart';
import 'repository/tiki_kv_repository.dart';

class TikiKVService {
  final TikiKVRepository _repository;

  TikiKVService({required Database database})
      : _repository = TikiKVRepository(database);

  Future<TikiKVModel?> getByKey(String key) async => _repository.getByKey(key);

  Future<TikiKVModel?> upsert(String key, String value) async {
    TikiKVModel? data = await getByKey(key);
    TikiKVModel dataToInsert =
        TikiKVModel(id: data?.id, key: data?.key ?? key, value: value);
    return data == null
        ? await _repository.insert(dataToInsert)
        : await _repository.update(dataToInsert);
  }

  Future<TikiKVModel?> newOrFail(String key, String value) async {
    TikiKVModel? data = await getByKey(key);
    if (data != null) throw Exception('The key $key already exists');
    TikiKVModel dataToInsert = TikiKVModel(id: null, key: key, value: value);
    return await _repository.insert(dataToInsert);
  }

  Future<void> delete(String key) async {
    TikiKVModel? data = await getByKey(key);
    if (data != null) await _repository.delete(data.id!);
  }

  Future<void> deleteAllData() async => await _repository.deleteAll();
}
