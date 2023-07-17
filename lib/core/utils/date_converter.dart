


class DateConverter{

  static String getTime(DateTime dt){
    try {
      final String dtHour = dt.hour.toString().length == 1
          ? "0${dt.hour}" : dt.hour.toString();
      final String dtMinute = dt.minute.toString().length == 1
          ? "0${dt.minute}" : dt.minute.toString();
      final String time = "$dtHour:$dtMinute";
      return time;
    } catch (e) { return ""; }
  }

  static String getTimeString(String dt){
    try {
      DateTime dt0 = DateTime.parse(dt);
      final String dtHour = dt0.hour.toString().length == 1
          ? "0${dt0.hour}" : dt0.hour.toString();
      final String dtMinute = dt0.minute.toString().length == 1
          ? "0${dt0.minute}" : dt0.minute.toString();
      final String time = "$dtHour:$dtMinute";
      return time;
    } catch (e) { return ""; }
  }

  static String getDateTimeWithMonth(DateTime dt){
    try {
      String monthName = "";
      if(dt.month == 1) {
        monthName = "January";
      } else if(dt.month == 2) {
        monthName = "February";
      } else if(dt.month == 3) {
        monthName = "March";
      } else if(dt.month == 4) {
        monthName = "April";
      } else if(dt.month == 5) {
        monthName = "May";
      } else if(dt.month == 6) {
        monthName = "June";
      } else if(dt.month == 7) {
        monthName = "July";
      } else if(dt.month == 8) {
        monthName = "August";
      } else if(dt.month == 9) {
        monthName = "September";
      } else if(dt.month == 10) {
        monthName = "October";
      } else if(dt.month == 11) {
        monthName = "November";
      } else if(dt.month == 12) {
        monthName = "December";
      }

      return "${dt.day} $monthName ${dt.year}, ${getTime(dt)}";
    } catch (e) { return ""; }
  }

}
