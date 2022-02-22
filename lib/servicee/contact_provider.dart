import 'package:contact/servicee/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactProvider {
  Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, "contact_db.db");

    return openDatabase(
      path,
      onCreate: (Database db, int version) {
        return db.execute("""
        CREATE TABLE contacts (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, phone TEXT)
        """);
      },
      version: 1,
    );
  }

  Future<List<Contact>> getContacts() async {
    var db = await initDb();
    var tt = await db.query("contacts");

    return tt.map((e) => Contact.fromJson(e)).toList();
  }

  void createContact(Contact contact) async {
    var db = await initDb();
    await db.insert("contacts", contact.toJson());
  }

  void deleteContact(id) async {
    var db = await initDb();
    await db.delete('contacts', where: "id=?", whereArgs: [id]);
  }
}
