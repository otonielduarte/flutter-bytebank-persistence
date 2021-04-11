import 'package:bytebank_persistense_app/styles/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NameCubit extends Cubit<String> {
  NameCubit(String name) : super(name);

  void change(String name) => emit(name);
}

class NameContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatefulWidget {
  @override
  _NameViewState createState() => _NameViewState();
}

class _NameViewState extends State<NameView> {
  final TextEditingController _nameController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Change name')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  _isButtonDisabled = value.isEmpty;
                });
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Desired name',
              ),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {
                  if (_isButtonDisabled) return null;
                  final newName = _nameController.text;
                  print(newName);
                  context.read<NameCubit>().change(newName);
                },
                child: Text('Change name'),
                style: ElevatedButton.styleFrom(
                  primary: _isButtonDisabled
                      ? byteBankTheme.buttonColor
                      : byteBankTheme.primaryColor, // background
                  onPrimary: _isButtonDisabled
                      ? Colors.white54
                      : Colors.grey[50], // foreground
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${context.watch<NameCubit>().state}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
