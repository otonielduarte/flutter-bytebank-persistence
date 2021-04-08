import 'package:bytebank_persistense_app/database/app_database.dart';
import 'package:bytebank_persistense_app/models/contact.dart';

class ContactDao {
  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  Future<int> save(Contact contact) async {
    final database = await getDatabase();
    return database.insert(_tableName, contact.toJson());
  }

  Future<List<Contact>> findAll() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> dbContacts =
        await database.query(_tableName);
    return dbContacts.map((value) => Contact.fromJson(value)).toList();
  }
}
