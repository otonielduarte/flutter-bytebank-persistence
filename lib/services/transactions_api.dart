import 'dart:convert';

import 'package:bytebank_persistense_app/models/transaction.dart';
import 'package:bytebank_persistense_app/services/base_api.dart';
import 'package:bytebank_persistense_app/services/exceptions/http_exception.dart';
import 'package:http/http.dart';

class TransactionApi {
  Future<List<Transaction>> findAllTransactions() async {
    final Response response =
        await client.get(Uri.parse('$baseUrl/transactions'));
    if (response.statusCode != 200) {
      return [];
    }
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic value) => Transaction.fromJson(value))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    await Future.delayed(Duration(seconds: 12));

    Response response = await client.post(Uri.parse('$baseUrl/transactions'),
        headers: {
          'content-type': 'application/json',
          'password': password,
        },
        body: jsonEncode(transaction.toJson()));

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    final message = _statusCodeResponses[response.statusCode];
    return throw HttpException(
        message != null ? message : 'Unknown Error error');
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed',
    409: 'Transaction already exists'
  };
}
