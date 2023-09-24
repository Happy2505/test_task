import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:test_task/models/transactions_item.dart';

import 'auth_widget/auth_widget.dart';
import 'base/shared.dart';
import 'main/transaction_widget.dart';
import 'redux/app_state.dart';
import 'redux/reducers.dart';
import 'redux/sharedPrefs_middleware.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await Shared.getPassword() == null) {
    Shared.setPassword('1234');
  }
  if (await Shared.getInitState() == null) {
    Shared.setInitState(
        '{ "transactionsItem": [ {"type": "Перевод","number": 1, "amount": 500,"commission": 0, "total": 0, "date": "24.09.2023"},{"type": "Пополнение","number": 2, "amount": 1000,"commission": 0, "total": 0, "date": "20.09.2023"}, {"type": "Снятие","number": 3, "amount": 1000,"commission": 0, "total": 0, "date": "19.09.2023"},{"type": "Перевод","number": 4, "amount": 5000,"commission": 0, "total": 5000, "date": "24.08.2023"}]}');
  }

  final Store<AppState> store = Store(
    appStateReducers,
    middleware: [SharedPrefsMiddleware()],
    initialState: AppState(const [TransactionsItem('', 0, 0, 0, 0, '')]),
  );

  runApp(MaterialApp(
    routes: {
      '/auth': (context) => const AuthWidget(),
      '/transaction': (context) => StoreProvider(
        store: store,
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Jost',
          ),
          home: const TransactionWidget(),
        ),
      ),
    },
    initialRoute: '/auth',
    theme: ThemeData(fontFamily: 'Jost'),
  ));
}
