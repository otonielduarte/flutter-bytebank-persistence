import 'package:bytebank_persistense_app/components/loading.dart';
import 'package:bytebank_persistense_app/database/dao/contact_dao.dart';
import 'package:bytebank_persistense_app/models/contact.dart';
import 'package:bytebank_persistense_app/screens/contact_form.dart';
import 'package:bytebank_persistense_app/screens/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Contacts';

class ContactsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactStateList();
  }
}

class ContactStateList extends State<ContactsWidget> {
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (context, snapshop) {
          switch (snapshop.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return LoadingComponent();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Contact> contacts = snapshop.data;
              if (contacts == null) {
                return Text('No contacts found');
              }
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) => _CardContact(
                  contacts[index],
                  handleOnTap: () => {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TransactionForm(contacts[index]),
                      ),
                    ),
                  },
                ),
              );
          }
          return Text('Unkown error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () => _navigateToForm(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _navigateToForm(context) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ContactForm(),
          ),
        )
        .then((value) => {setState(() {})});
  }
}

class _CardContact extends StatelessWidget {
  final Contact contact;
  final Function handleOnTap;

  _CardContact(this.contact, {@required this.handleOnTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => handleOnTap(),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
