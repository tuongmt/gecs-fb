import 'package:intl/intl.dart';

String numberFormatter(double amount) {
  return NumberFormat('###,###.###').format(amount);
}
