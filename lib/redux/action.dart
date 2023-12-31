
import 'package:equatable/equatable.dart';

import '../models/transactions_item.dart';

class ItemLoadedAction extends Equatable {
  final List<TransactionsItem> items;

  const ItemLoadedAction(this.items);

  @override
  List<Object> get props => [items];
}

class RemoveItemAction extends Equatable {
  final TransactionsItem item;

  const RemoveItemAction(this.item);

  @override
  List<Object> get props => [item];
}

class FetchItemsAction extends Equatable {
  @override
  List<Object> get props => [];
}