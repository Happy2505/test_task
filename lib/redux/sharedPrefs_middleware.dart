import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';

import '../base/shared.dart';
import 'app_state.dart';
import 'action.dart';

class SharedPrefsMiddleware extends MiddlewareClass<AppState> {
  SharedPrefsMiddleware();

  @override
  Future<void> call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RemoveItemAction) {
      await _saveStateToPrefs(store.state);
    }

    if (action is FetchItemsAction) {
      await _loadStateFromPrefs(store);
    }
    next(action);
  }

  Future _saveStateToPrefs(AppState state) async {
    var stateString = json.encode(state.toJson());
    Shared.setInitState(stateString);
  }

  Future _loadStateFromPrefs(Store<AppState> store) async {
    var stateString = await Shared.getInitState();
    if (stateString == null) return;
    var state = AppState.fromJson(json.decode(stateString));
    store.dispatch(ItemLoadedAction(state.transactionsItem!));
  }
}
