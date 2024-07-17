import 'package:intl/intl.dart';

String get getApplicationContent {
  final time = DateFormat("HH").format(
    DateTime.now(),
  );

  List<String> splitTime = time.split(":");
  int hour = int.parse(splitTime[0]);

  if (hour > 6 && hour <= 12) {
    return "Günaydın";
  } else if (hour > 12 && hour <= 18) {
    return "Selam";
  } else if (hour > 18 && hour <= 24) {
    return "İyi Akşamlar";
  } else if (hour > 0 && hour <= 6) {
    return "İyi Geceler";
  }
  return "";
}
