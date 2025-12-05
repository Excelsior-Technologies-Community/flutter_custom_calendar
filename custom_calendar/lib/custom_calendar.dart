library custom_calendar;

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    super.key,
    this.events = const {},
    this.holidays = const {},
    this.holidaySelectColor = Colors.blue,
    this.eventSelectColor = Colors.red, this.todaySelectColor = Colors.orange,
  });

  final Map<DateTime, List<String>> events;
  final Map<DateTime, String> holidays;
  final Color holidaySelectColor;
  final Color eventSelectColor;
  final Color todaySelectColor;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  String selectedDayMessage = "";

  List<String> getEventsForDay(DateTime day) {
    DateTime d = DateTime(day.year, day.month, day.day);
    return widget.events[d] ?? [];
  }

  String? getHolidayName(DateTime day) {
    DateTime d = DateTime(day.year, day.month, day.day);
    return widget.holidays[d];
  }

  bool isHoliday(DateTime day) => getHolidayName(day) != null;

  void selectTime() async {
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selected time: ${time.format(context)}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),
          focusedDay: focusedDay,
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),

          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;

              String? holiday = getHolidayName(selected);
              List<String> events = getEventsForDay(selected);

              if (holiday != null) {
                selectedDayMessage = "This date is $holiday holiday";
              } else if (events.isNotEmpty) {
                selectedDayMessage = "This date has ${events.join(', ')} event";
              } else {
                selectedDayMessage = "No events on this day";
              }
            });
          },

          eventLoader: getEventsForDay,

          holidayPredicate: (day) => isHoliday(day),

          calendarStyle:  CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.orange,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: widget.holidaySelectColor,
              shape: BoxShape.circle,
            ),
            markerDecoration: BoxDecoration(
              color: widget.eventSelectColor,
              shape: BoxShape.circle,
            ),
          ),
        ),

        ElevatedButton(onPressed: selectTime, child: const Text("Select Time")),

        const Divider(),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            selectedDayMessage,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
