import 'package:intl/intl.dart';

List<DateTime> getNextTwoWeeks(List<String> dayNames) {
  List<DateTime> result = [];

  DateTime now = DateTime.now();

  // Calculate the next two weeks' dates for each day in the list
  for (int i = 0; i < 30; i++) {
    DateTime nextDate = now.add(Duration(days: i));
    String formattedDate = DateFormat('yyyy-MM-dd').format(nextDate);
    String formattedDay = DateFormat('EEEE').format(nextDate);

    // Check if the formatted day matches any day in the provided list
    if (dayNames.map((e) => e.toLowerCase()).contains(formattedDay.toLowerCase())) {
      result.add(DateTime.parse(formattedDate));
    }
  }

  return result;
}

DateTime? getDate(String day, DateTime date) {
  

  // Calculate the next two weeks' dates for each day in the list
  for (int i = 0; i < 30; i++) {
    // DateTime nextDate = now.add(Duration(days: i));
    DateTime now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime nextDate = now.add(Duration(days: i));
    // String formattedDay = DateFormat('EEEE').format(nextDate);
// print("${_getWeekdayFromString(day.toLowerCase())} -> ${nextDate.weekday} => ${_getWeekdayFromString(day.toLowerCase()) == nextDate.weekday}");
    if (_getWeekdayFromString(day.toLowerCase()) == nextDate.weekday && date == nextDate) {
      return nextDate;
      // print("${_getWeekdayFromString(day.toLowerCase())} -> ${nextDate.weekday} => $nextDate => ${_getWeekdayFromString(day.toLowerCase()) == nextDate.weekday && date == nextDate}");
 
    }
  }

  return null;
}
DateTime? getDate1(String day) {
  DateTime now = DateTime.now();
  int currentWeekday = now.weekday;
  int targetWeekday = _getWeekdayFromString(day);

  // Calculate the number of days to add to the current date to reach the target weekday
  int daysToAdd = (targetWeekday - currentWeekday + 7) % 7;

  // Add the calculated number of days to the current date to get the next occurrence of the target weekday
  DateTime nextDate = now.add(Duration(days: daysToAdd));

  return nextDate;
}

int _getWeekdayFromString(String day) {
  switch (day.toLowerCase()) {
    case 'monday':
      return DateTime.monday;
    case 'tuesday':
      return DateTime.tuesday;
    case 'wednesday':
      return DateTime.wednesday;
    case 'thursday':
      return DateTime.thursday;
    case 'friday':
      return DateTime.friday;
    case 'saturday':
      return DateTime.saturday;
    case 'sunday':
      return DateTime.sunday;
    default:
      throw Exception('Invalid day name: $day');
  }
}
