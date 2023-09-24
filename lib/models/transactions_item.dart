import 'package:equatable/equatable.dart';

class TransactionsItem extends Equatable {
  final String type;
  final int number;
  final int amount;
  final int commission;
  final int total;
  final String date;

  const TransactionsItem(this.type, this.number, this.amount, this.commission,
      this.total, this.date);

  TransactionsItem.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        number = json['number'],
        amount = json['amount'],
        commission = json['commission'],
        total = json['total'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'number': number,
        'amount': amount,
        'commission': commission
      };

  // @override
  // String toString() {
  //   return "$name: $checked";
  // }

  @override
  List<Object> get props => [type, number, amount, commission];
}
