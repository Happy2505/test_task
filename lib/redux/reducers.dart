

import 'app_state.dart';
import '../models/transactions_item.dart';
import 'action.dart';

AppState appStateReducers(AppState state, dynamic action) {
  // if (action is AddItemAction) {
  //   return addItem(state.cartItems, action);
  // } else if (action is ToggleItemStateAction) {
  //   return toggleItemState(state.cartItems, action);
  // } else if (action is RemoveItemAction) {
  //   return removeItem(state.cartItems, action);
  // } else if (action is ItemLoadedAction) {
  //   return loadItems(action);
  // }
  if (action is ItemLoadedAction) {
    return loadItems(action);
  } else if (action is RemoveItemAction) {
      return removeItem(state.transactionsItem!, action);
    }

  return state;
}

// AppState addItem(List<TransactionsItem> items, AddItemAction action) {
//   return AppState(List.from(items)..add(action.item));
// }


AppState removeItem(List<TransactionsItem> items, RemoveItemAction action) {
  return AppState(List.from(items)..removeWhere((item) => item.number == action.item.number));
}

AppState loadItems(ItemLoadedAction action) {
  return AppState(action.items);
}