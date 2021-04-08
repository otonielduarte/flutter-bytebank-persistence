import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransactionDialog({
    Key key,
    @required this.onConfirm,
  }) : super(key: key);

  @override
  _TransactionDialogState createState() => _TransactionDialogState();
}

class _TransactionDialogState extends State<TransactionDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        controller: _passwordController,
        maxLength: 4,
        obscureText: true,
        decoration: InputDecoration(border: OutlineInputBorder()),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 32, letterSpacing: 24),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => {
            widget.onConfirm(_passwordController.text),
            Navigator.pop(context),
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
