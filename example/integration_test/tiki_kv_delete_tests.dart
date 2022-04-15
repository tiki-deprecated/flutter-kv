import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_kv/tiki_kv.dart';

void main() async {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('KV Delete Testing', () {
    testWidgets('Delete an Item', (WidgetTester tester) async {
      // Build our example app and trigger a frame.

      Database database = await open("password");
      TikiKv kv = TikiKv(database: database);
      kv.init();

      await kv.create("test", "VAL");

      expect(await kv.read("test"), "VAL");

      await kv.delete("test");

      expect(await kv.read("test"), null);
    });

    testWidgets('Testing delete all', (WidgetTester tester) async {
      // Build our example app and trigger a frame.

      Database database = await open("password");
      TikiKv kv = TikiKv(database: database);
      kv.init();

      await kv.create("test", "VAL");
      await kv.create("test 2", "VAL 2");
      await kv.create("test 3", "VAL 2");
      await kv.create("test 4", "VAL 2");

      expect(await kv.read("test"), "VAL");

      await kv.deleteAll();

      expect(await kv.read("test"), null);
      expect(await kv.read("test 2"), null);
      expect(await kv.read("test 3"), null);
      expect(await kv.read("test 4"), null);

    });

  });

}

Future<Database> open(String password) async {
  String dbName = 'tiki_app.db';
  String databasePath = await getDatabasesPath() + '/' + dbName;
  await deleteDatabase(databasePath);
  return await openDatabase(databasePath, password: password);
}