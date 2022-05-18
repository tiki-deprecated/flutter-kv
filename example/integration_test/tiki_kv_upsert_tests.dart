import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_kv/tiki_kv.dart';

void main() async {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Upsert Testing', () {
    testWidgets('Changes upserted item', (WidgetTester tester) async {
      // Build our example app and trigger a frame.

      Database database = await open("password");
      TikiKv kv = TikiKv(database: database);
      kv.init();

      await kv.create("test", "VAL");
      await kv.upsert("test", "VAL2");

      expect(await kv.read("test"), "VAL2");
    });

    testWidgets('Upsert inserts item', (WidgetTester tester) async {
      // Build our example app and trigger a frame.

      Database database = await open("password");
      TikiKv kv = TikiKv(database: database);
      kv.init();

      await kv.upsert("test", "VAL3");

      expect(await kv.read("test"), "VAL3");
    });

  });

}

Future<Database> open(String password) async {
  String dbName = 'tiki_app.db';
  String databasePath = await getDatabasesPath() + '/' + dbName;
  await deleteDatabase(databasePath);
  return await openDatabase(databasePath, password: password);
}