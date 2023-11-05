import 'package:flutter/material.dart';

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

class NotificationWeekAndTime {
  final int dayOfTheWeek;
  final TimeOfDay timeOfDay;

  NotificationWeekAndTime({
    required this.dayOfTheWeek,
    required this.timeOfDay,
  });
}

Future<NotificationWeekAndTime?> pickSchedule(
  BuildContext context,
) async {
  List<String> weekofmonth = [
    '1st week',
    '2nd week',
    '3rd week',
    '4th week',
    '5th week',
    '6th week',
  ];
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();
  int? selectedWeek;

  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'I want to be reminded every:',
            textAlign: TextAlign.center,
          ),
          content: Wrap(
            alignment: WrapAlignment.center,
            spacing: 3,
            children: [
              for (int index = 0; index < weekofmonth.length; index++)
                ElevatedButton(
                  onPressed: () {
                    selectedWeek = index + 1;
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Colors.blue,
                    ),
                  ),
                  child: Text(weekofmonth[index]),
                ),
            ],
          ),
        );
      });

  if (selectedWeek != null) {
    timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.teal,
              ),
            ),
            child: child!,
          );
        });

    if (timeOfDay != null) {
      return NotificationWeekAndTime(
          dayOfTheWeek: selectedWeek!, timeOfDay: timeOfDay);
    }
  }
  return null;
}

class NotificationEveryDayAtTime {
  final TimeOfDay timeOfDay;

  NotificationEveryDayAtTime({
    required this.timeOfDay,
  });
}

Future<NotificationEveryDayAtTime?> pickScheduleEveryDay(
  BuildContext context,
) async {
  TimeOfDay? timeOfDay;
  DateTime now = DateTime.now();

    timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
          now.add(
            Duration(minutes: 1),
          ),
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
              colorScheme: ColorScheme.light(
                primary: Colors.teal,
              ),
            ),
            child: child!,
          );
        });

    if (timeOfDay != null) {
      return NotificationEveryDayAtTime(
          timeOfDay: timeOfDay);
    
  }
  return null;
}
