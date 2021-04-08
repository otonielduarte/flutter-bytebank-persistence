import 'dart:async';

import 'package:bytebank_persistense_app/components/loading.dart';
import 'package:bytebank_persistense_app/components/response_dialog.dart';
import 'package:bytebank_persistense_app/components/transaction_dialog.dart';
import 'package:bytebank_persistense_app/models/contact.dart';
import 'package:bytebank_persistense_app/models/transaction.dart';
import 'package:bytebank_persistense_app/services/exceptions/http_exception.dart';
import 'package:bytebank_persistense_app/services/transactions_api.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const String titleAppbar = 'New transaction';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  TransactionForm(this.contact);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _valueController = TextEditingController();
  final TransactionApi _transactionApi = TransactionApi();
  final String transactionId = Uuid().v4();
  bool _isSending = false;

  @override
  Widget build(BuildContext context) {
    print('uuid $transactionId');
    return Scaffold(
      appBar: AppBar(
        title: Text(titleAppbar),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Visibility(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: LoadingComponent(
                    message: 'Sending...',
                  ),
                ),
                visible: _isSending,
              ),
              Text(
                widget.contact.name,
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  controller: _valueController,
                  style: TextStyle(fontSize: 24.0),
                  decoration: InputDecoration(labelText: 'Value'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    child: Text('Transfer'),
                    onPressed: () {
                      final double value =
                          double.tryParse(_valueController.text);
                      if (!value.isNaN) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return TransactionDialog(
                              onConfirm: (String password) {
                                _save(
                                  Transaction(
                                    transactionId,
                                    value,
                                    widget.contact,
                                  ),
                                  password,
                                  context,
                                );
                              },
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _save(
    Transaction newTransaction,
    String password,
    BuildContext context,
  ) async {
    setState(() {
      _isSending = true;
    });
    final Transaction transaction =
        await _transactionApi.save(newTransaction, password).catchError(
      (e) {
        _showFailureMessage(
          context,
          message: e.message,
        );
      },
      test: (e) => e is HttpException,
    ).catchError(
      (e) {
        _showFailureMessage(
          context,
          message: 'timeout submitting the transaction',
        );
      },
      test: (e) => e is TimeoutException,
    ).catchError((e) {
      _showFailureMessage(context);
    }).whenComplete(() {
      setState(() {
        _isSending = false;
      });
    });

    if (transaction != null) {
      _showSuccessMessage(context);
    }
  }

  void _showFailureMessage(BuildContext context, {message: 'Unknow Error'}) {
    showDialog(
        context: context, builder: (contextDialog) => FailureDialog(message));
  }

  void _showSuccessMessage(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (contexDialog) => SuccessDialog('Transaction has sended'));
    Navigator.pop(context);
  }
}
