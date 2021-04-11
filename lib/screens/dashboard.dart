import 'package:bytebank_persistense_app/screens/contact_list.dart';
import 'package:bytebank_persistense_app/screens/name.dart';
import 'package:bytebank_persistense_app/screens/transaction_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatelessWidget {
  void _navigateToContacts(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ContactsWidget(),
      ),
    );
  }

  void _navigateToFeed(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionFeed(),
      ),
    );
  }

  void _navigateToChangeName(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (routerContext) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(context),
          child: NameContainer(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard ${context.watch<NameCubit>().state}'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Image.asset('images/bytebank_logo.png'),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _DashboardItem(
                  'Transfer',
                  Icons.monetization_on,
                  onTap: () => _navigateToContacts(context),
                ),
                _DashboardItem(
                  'Transaction Feed',
                  Icons.description,
                  onTap: () => _navigateToFeed(context),
                ),
                _DashboardItem(
                  'Change name',
                  Icons.people,
                  onTap: () => _navigateToChangeName(context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onTap;

  _DashboardItem(this.name, this.icon, {@required this.onTap})
      : assert(icon != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => onTap(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              width: 120,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
