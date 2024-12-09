import 'package:kasir/models/Product.dart';

class Transaction {
  final List<Product> products; 
  final double totalAmount; 
  final int transactionId; 

  Transaction({
    required this.products,
    required this.totalAmount,
    required this.transactionId,
  });
}
