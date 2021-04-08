import 'dart:convert';

import 'package:bytebank_persistense_app/models/transaction.dart';
import 'package:bytebank_persistense_app/services/base_api.dart';
import 'package:http/http.dart';

const String transactionUrl = 'http://192.168.0.108:8080/transactions';

class TransactionApi {
  Future<List<Transaction>> findAllTransactions() async {
    final Response response = await client.get(Uri.parse(transactionUrl));
    if (response.statusCode != 200) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic value) => Transaction.fromJson(value))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    Response response = await client.post(Uri.parse(transactionUrl),
        headers: {
          'content-type': 'application/json',
          'password': '1000',
        },
        body: jsonEncode(transaction.toJson()));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    return null;
  }
}
