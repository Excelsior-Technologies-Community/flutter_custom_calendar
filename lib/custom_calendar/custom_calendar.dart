import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarScreen extends StatefulWidget {
  const CustomCalendarScreen({super.key});

  @override
  _CustomCalendarScreenState createState() => _CustomCalendarScreenState();
}

class _CustomCalendarScreenState extends State<CustomCalendarScreen> {
  DateTime focusedDay = DateTime.now();
  DateTime? startDay;
  DateTime? endDay;

  DateTime? selectedDay;
  String selectedDayMessage = "";

  /// FIX: Normalized event dates
  Map<DateTime, List<String>> events = {
    DateTime(2026, 1, 15): ["Meeting"],
    DateTime(2026, 1, 20): ["Birthday"],
  };

  Map<DateTime, String> holidays = {
    DateTime(2026, 1, 26): "Republic Day",
    DateTime(2026, 1, 14): "Makar Sankranti",
    DateTime(2026, 8, 15): "Independence Day",
    DateTime(2026, 10, 2): "Gandhi Jayanti",
  };

  List<String> getEventsForDay(DateTime day) {
    DateTime d = DateTime(day.year, day.month, day.day);
    return events[d] ?? [];
  }

  String? getHolidayName(DateTime day) {
    DateTime d = DateTime(day.year, day.month, day.day);
    return holidays[d];
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
    return Scaffold(
      appBar: AppBar(title: const Text("Custom Calendar")),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: focusedDay,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: CalendarFormat.month,
            startingDayOfWeek: StartingDayOfWeek.monday,

            rangeStartDay: startDay,
            rangeEndDay: endDay,
            rangeSelectionMode: RangeSelectionMode.disabled,

            onRangeSelected: (start, end, day) {
              setState(() {
                startDay = start;
                endDay = end;
                selectedDay = null;
              });
            },

            selectedDayPredicate: (day) => isSameDay(selectedDay, day),

            onDaySelected: (selected, focused) {
              setState(() {
                selectedDay = selected;
                focusedDay = focused;

                String? holidayName = getHolidayName(selected);
                List<String> dayEvents = getEventsForDay(selected);

                if (holidayName != null) {
                  selectedDayMessage = "This date is $holidayName holiday";
                } else if (dayEvents.isNotEmpty) {
                  selectedDayMessage =
                  "This date has ${dayEvents.join(', ')} event";
                } else {
                  selectedDayMessage = "No events on this day";
                }
              });
            },

            eventLoader: getEventsForDay,

            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              holidayTextStyle: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              holidayDecoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1.5),
                shape: BoxShape.circle,
              ),
            ),

            holidayPredicate: (day) => isHoliday(day),

            onPageChanged: (day) => focusedDay = day,
          ),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: selectTime,
            child: Text("Select Time"),
          ),

          Divider(),

          /// 🔥 MESSAGE BELOW DIVIDER
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              selectedDayMessage,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          Expanded(
            child: ListView(
              children: getEventsForDay(selectedDay ?? focusedDay)
                  .map(
                    (e) => ListTile(
                  leading: Icon(Icons.event),
                  title: Text(e),
                ),
              )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
