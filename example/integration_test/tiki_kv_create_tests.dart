import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:tiki_kv/tiki_kv.dart';

void main() async {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('KV Create Testing', () {
    testWidgets('Create 3 Items & Check Null Value', (WidgetTester tester) async {
      // Build our example app and trigger a frame.

      Database database = await open("password");
      TikiKv kv = TikiKv(database: database);
      kv.init();

      await kv.create("test", "VAL");
      await kv.create("wewewe kwek wke kwek wke kwke kwe ", "VAL 2");
      await kv.create("test22", "VAL");

      expect(await kv.read("unset key"), null);
      expect(await kv.read("test"), "VAL");
      expect(await kv.read("wewewe kwek wke kwek wke kwke kwe "), "VAL 2");
      expect(await kv.read("test22"), "VAL");
    });

    testWidgets('Should Error On Dup. Create', (WidgetTester tester) async {
      // Build our example app and trigger a frame.

      Database database = await open("password");
      TikiKv kv = TikiKv(database: database);
      kv.init();

      await kv.create("test", "VAL");

      try {
        await kv.create("test", "VAL");

        fail("Duplicate inserts s hould cause error");
      } catch (e) {
        // test passed
      }

    });

  });

}

Future<Database> open(String password) async {
  String dbName = 'tiki_app.db';
  String databasePath = await getDatabasesPath() + '/' + dbName;
  await deleteDatabase(databasePath);
  return await openDatabase(databasePath, password: password);
}