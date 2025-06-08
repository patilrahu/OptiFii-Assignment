import 'package:intl/intl.dart';

String formatDate(String dateString) {
  try {
    final date = DateTime.parse(dateString);
    return DateFormat('dd MMMM yyyy - hh:mm a').format(date);
  } catch (e) {
    return dateString;
  }
}
