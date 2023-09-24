import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_task/models/transactions_item.dart';
import 'package:test_task/redux/action.dart';

import '../redux/app_state.dart';

class DescTransactionWidget extends StatelessWidget {
  final TransactionsItem transactions;

  const DescTransactionWidget(this.transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Номер транзакции: ${transactions.number.toString()}"),
      ),
      bottomSheet:
          StoreConnector<AppState, OnRemoveIconClicked>(converter: (store) {
        return (transactions) => store.dispatch(RemoveItemAction(transactions));
      }, builder: (context, callback) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                callback(transactions);
                Navigator.pop(context);
              },
              child: const Text(
                "Отменить транзакцию",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        );
      }),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(16),
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              color: Colors.blueGrey),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Дата транзакции: ${transactions.date}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white,
              ),
              Text(
                "Сумма транзакции: ${transactions.amount} руб.",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white,
              ),
              Text(
                "Комиссия транзакции: ${transactions.commission} руб.",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white,
              ),
              Text(
                "Итог: ${transactions.total} руб.",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white,
              ),
              Text(
                "Номер транзакции: ${transactions.number}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white,
              ),
              Text(
                "Тип транзакции: ${transactions.type}",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef OnRemoveIconClicked = Function(TransactionsItem item);
