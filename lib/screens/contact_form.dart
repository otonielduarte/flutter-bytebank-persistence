import 'dart:ui';

import 'package:bytebank_persistense_app/database/dao/contact_dao.dart';
import 'package:bytebank_persistense_app/models/contact.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Create new contact';
const _formLabelName = 'Full name';
const _placeholderName = 'John Doe';
const _formLabelAccountNumber = 'Account number';
const _placeholderAccount = '123456';
const _btnTextName = 'Create';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final ContactDao _dao = ContactDao();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: _formLabelName,
                  hintText: _placeholderName,
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: TextField(
                  controller: _accountController,
                  decoration: InputDecoration(
                    labelText: _formLabelAccountNumber,
                    hintText: _placeholderAccount,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: double.maxFinite,
                  height: 45.0,
                  child: ElevatedButton(
                    onPressed: () => _handlePress(context),
                    child: Text(_btnTextName),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handlePress(context) {
    final accountNumber = int.tryParse(_accountController.text);
    final name = _nameController.text;
    if (accountNumber != null && name != null) {
      _dao.save(Contact(0, name, accountNumber))
          .then((id) => Navigator.pop(context));
    }
  }
}
