import 'package:bytebank_persistense_app/components/centered_message.dart';
import 'package:bytebank_persistense_app/components/loading.dart';
import 'package:bytebank_persistense_app/models/transaction.dart';
import 'package:bytebank_persistense_app/services/transactions_api.dart';
import 'package:flutter/material.dart';

const String _appBarTitle = 'Transaction Feed';

class TransactionFeed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TransactionWidght();
  }
}

class TransactionWidght extends State<TransactionFeed> {
  final TransactionApi _transactionApi = TransactionApi();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_appBarTitle),
        ),
        body: FutureBuilder<List<Transaction>>(
          initialData: [],
          /* future: Future.delayed(Duration(seconds: 3)).then((value) => findAllTransactions()), */
          future: _transactionApi.findAllTransactions(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return LoadingComponent();
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData && snapshot.data.isNotEmpty) {
                  final List<Transaction> transactions = snapshot.data;
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction transaction = transactions[index];
                      return _CardContact(transaction);
                    },
                    itemCount: transactions.length,
                  );
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
            }
            return Text('Unknow Error');
          },
        ),
      ),
    );
  }
}

class _CardContact extends StatelessWidget {
  final Transaction transaction;

  _CardContact(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transaction.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${transaction.contact.name} - ${transaction.contact.accountNumber.toString()}',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
