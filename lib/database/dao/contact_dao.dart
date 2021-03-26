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
    Map<String, dynamic> contactMap = _toMap(contact);
    return database.insert(_tableName, contactMap);
  }

  Future<List<Contact>> findAll() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> dbContacts =
        await database.query(_tableName);
    return _toList(dbContacts);
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  List<Contact> _toList(List<Map<String, dynamic>> dbContacts) {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> item in dbContacts) {
      contacts.add(Contact(
        item[_id],
        item[_name],
        item[_accountNumber],
      ));
    }
    return contacts;
  }
}
