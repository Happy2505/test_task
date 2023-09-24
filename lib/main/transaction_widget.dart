import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../base/shared.dart';
import '../redux/app_state.dart';
import '../models/transactions_item.dart';
import '../redux/action.dart';
import 'desc_transaction_widget.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
        onInit: (store) => store.dispatch(FetchItemsAction()),
        builder: (context, store) => const Transaction());
  }
}

class Transaction extends StatelessWidget {
  const Transaction({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TransactionListViewModel>(
        converter: (store) => TransactionListViewModel.build(store),
        builder: (context, vm) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Транзакции'),
              leading: IconButton(
                icon: const Icon(Icons.replay),
                onPressed: () {
                  vm.onRefresh();
                },
              ),
            ),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
                child: Builder(builder: (context) {
                  if (vm.cartItems.isNotEmpty) {
                    return ListView.builder(
                        itemCount: vm.cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => DescTransactionWidget(
                                          vm.cartItems[index])));
                            },
                            child: Card(
                              elevation: 3,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 22),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Тип транзакции: ${vm.cartItems[index].type}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "Номер транзакции: ${vm.cartItems[index].number}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "Сумма транзакции: ${vm.cartItems[index].amount} руб.",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: Text(
                        "Список транзакция пуст!",
                        style: TextStyle(fontSize: 20)
                      ),
                    );
                  }
                })),
          );
        });
  }
}

class TransactionListViewModel {
  final List<TransactionsItem> cartItems;
  final Function() onRefresh;

  TransactionListViewModel({required this.cartItems, required this.onRefresh});

  static TransactionListViewModel build(Store<AppState> store) {
    return TransactionListViewModel(
      cartItems: store.state.transactionsItem!,
      onRefresh: () {
        Shared.setInitState(
            '{ "transactionsItem": [ {"type": "Перевод","number": 1, "amount": 500,"commission": 0, "total": 0, "date": "24.09.2023"},{"type": "Пополнение","number": 2, "amount": 1000,"commission": 0, "total": 0, "date": "24.09.2023"}, {"type": "Снятие","number": 3, "amount": 1000,"commission": 0, "total": 0, "date": "24.09.2023"}]}');

        store.dispatch(FetchItemsAction());
      },
    );
  }
}

typedef OnStateChanged = Function(bool isLoading);
