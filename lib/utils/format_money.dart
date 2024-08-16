import 'package:intl/intl.dart';

String formatMoney(dynamic amount, {bool useDecimal = false}) {
  if (amount is int || amount is double) {
    // Format the amount with two decimal places and commas for thousands
    final formattedAmount = NumberFormat("#,##0.00", "en_US").format(amount);
    final formattedAmount1 = NumberFormat("#,##0", "en_US").format(amount);
    // useDecimal
    return useDecimal ? formattedAmount : formattedAmount1;
  } else {
    return "0";
  }
}
