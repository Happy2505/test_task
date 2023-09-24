import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:test_task/redux/app_state.dart';

import '../models/transactions_item.dart';
import '../ui/donut.dart';

class DiagramWidget extends StatelessWidget {
  const DiagramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(30, 0, 0, 0),
      appBar: AppBar(
        title: Text('Диаграмма'),
        centerTitle: true,
      ),
        body: StoreConnector<AppState, AppState>(
            converter: (store) => store.state,
            builder: (context, vm) {
              return Builder(builder: (context) {
                if (vm.transactionsItem!.isEmpty) {
                  return const SizedBox.shrink();
                }
                Map<String, int> transactionCounts = {};
                if (vm.transactionsItem != null) {
                  for (TransactionsItem transaction in vm.transactionsItem!) {
                    String transactionType = transaction.type;
                    if (transactionCounts.containsKey(transactionType)) {
                      transactionCounts[transactionType] =
                          transactionCounts[transactionType]! + 1;
                    } else {
                      transactionCounts[transactionType] = 1;
                    }
                  }
                }
                return DonutChart(transactionCounts: transactionCounts);
              });
            }));
  }
}
