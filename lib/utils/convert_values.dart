import 'package:intl/intl.dart';

final DateFormat dateFormat = DateFormat("yyyy-MM-dd", "pt_BR");

String changeTheDateWriting(String date) {
  final splitDate = date.split("-");
  return "${splitDate[2]}/${splitDate[1]}/${splitDate[0]}";
}