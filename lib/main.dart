import 'package:bytebank_persistense_app/helpers/global_observer.dart';
import 'package:bytebank_persistense_app/screens/dashboard.dart';
import 'package:bytebank_persistense_app/screens/name.dart';
import 'package:bytebank_persistense_app/styles/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(ByteBankApp());
}

class ByteBankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: byteBankTheme,
      home: BlocProvider(
        create: (_) => NameCubit("Otoniel"),
        child: Dashboard(),
      ),
    );
  }
}
