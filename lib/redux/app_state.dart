import 'package:equatable/equatable.dart';
import 'package:test_task/models/transactions_item.dart';

class AppState extends Equatable {
  List<TransactionsItem>? transactionsItem;

  AppState(this.transactionsItem);

  AppState.fromJson(Map<String, dynamic> json){
    if (json['transactionsItem'] != null) {
      transactionsItem = <TransactionsItem>[];
      json['transactionsItem'].forEach((v) {
        transactionsItem!.add(TransactionsItem.fromJson(v));
      });
    }
  }
  factory AppState.empty() => AppState([]);

  Map<String, dynamic> toJson() => {'cartItems': transactionsItem};

  @override
  String toString() => "$transactionsItem";

  @override
  List<Object> get props => [transactionsItem!];
}
