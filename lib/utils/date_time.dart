import 'package:intl/intl.dart';

int setDate() {
  return DateTime.now().millisecondsSinceEpoch;
}

String getDateFromSTMP(int timestamp) {
  var format = DateFormat('dd MMM, E hh:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var time = format.format(date);
  return time;
}

// bool calcTimeDifference(mins) =>
//     DateFormat('d MMM yyyy::hh:mm a').format(date.toDate());
