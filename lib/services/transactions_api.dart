import 'dart:convert';

import 'package:bytebank_persistense_app/models/contact.dart';
import 'package:bytebank_persistense_app/models/transaction.dart';
import 'package:bytebank_persistense_app/services/base_api.dart';
import 'package:http/http.dart';

const String transactionUrl = 'http://192.168.0.103:8080/transactions';

class TransactionApi {
  
  Future<List<Transaction>> findAllTransactions() async {
    final Response response = await client.get(Uri.parse(transactionUrl));
    if (response.statusCode != 200) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(response.body);
    final List<Transaction> transactionsResponse = [];
    for (Map<String, dynamic> value in decodedJson) {
      Transaction transaction = _jsonToTransaction(value);
      transactionsResponse.add(transaction);
    }
    return transactionsResponse;
  }
  
  Future<Transaction> save(Transaction transaction) async {
    Map<String, dynamic> json = _transactionToJsonMap(transaction);

    Response response = await client.post(Uri.parse(transactionUrl),
        headers: {
          'content-type': 'application/json',
          'password': '1000',
        },
        body: jsonEncode(json));

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return _jsonToTransaction(decodedJson);
    }

    return null;
  }

  Transaction _jsonToTransaction(Map<String, dynamic> jsonValue) {
    final transaction = Transaction(
      jsonValue['id'],
      jsonValue['value'],
      Contact(
        0,
        jsonValue['contact']['name'],
        jsonValue['contact']['accountNumber'],
      ),
    );
    return transaction;
  }


  Map<String, dynamic> _transactionToJsonMap(Transaction transaction) {
    final Map<String, dynamic> jsonMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
        'id': transaction.contact.id,
      }
    };
    return jsonMap;
  }
}
