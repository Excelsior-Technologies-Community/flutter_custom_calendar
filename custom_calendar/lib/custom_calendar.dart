library custom_calendar;

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({
    super.key,
    this.events = const {},
    this.holidays = const {},
    this.holidaySelectColor = Colors.blue,
    this.holidayBackGroundColor = Colors.transparent,
    this.holidayBorderColor = Colors.blue,
    this.eventSelectColor = Colors.red,
    this.todaySelectColor = Colors.orange,
    this.rangeStartColor = Colors.green,
    this.rangeEndColor = Colors.green,
    this.timeSelectButtonText,
    this.buttonStyle,
    this.scheduleText,
  });

  final Map<DateTime, List<String>> events;
  final Map<DateTime, String> holidays;
  final Color holidaySelectColor;
  final Color holidayBackGroundColor;
  final Color holidayBorderColor;
  final Color eventSelectColor;
  final Color todaySelectColor;
  final Color rangeStartColor;
  final Color rangeEndColor;
  final String? timeSelectButtonText;
  final ButtonStyle? buttonStyle;
  final String? scheduleText;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  /// 🔥 Range Picker Variables
  DateTime? rangeStart;
  DateTime? rangeEnd;
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode.toggledOff;

  /// 🔥 Schedule View List
  List<String> scheduleList = [];

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

  /// 🔥 Get Schedule For Date Range
  List<String> getScheduleForRange(DateTime start, DateTime end) {
    List<String> list = [];

    DateTime d = start;

    while (!d.isAfter(end)) {
      List<String> ev = getEventsForDay(d);
      String? hol = getHolidayName(d);

      if (hol != null)
        list.add("${d.day}-${d.month}-${d.year}: Holiday - $hol");
      if (ev.isNotEmpty) {
        list.add("${d.day}-${d.month}-${d.year}: Events - ${ev.join(', ')}");
      }

      d = d.add(const Duration(days: 1));
    }

    return list;
  }

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
        /// 🔥 Calendar with Range Picker
        TableCalendar(
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
          ),

          focusedDay: focusedDay,
          firstDay: DateTime(2020),
          lastDay: DateTime(2030),

          selectedDayPredicate: (day) => isSameDay(selectedDay, day),

          /// 🔥 Add range selection properties
          rangeStartDay: rangeStart,
          rangeEndDay: rangeEnd,
          rangeSelectionMode: rangeSelectionMode,

          /// 🔥 RANGE SELECT WORKS NOW
          onRangeSelected: (start, end, focusedNew) {
            setState(() {
              rangeStart = start;
              rangeEnd = end;
              focusedDay = focusedNew;

              /// Enable range mode when user selects 2 dates
              rangeSelectionMode = RangeSelectionMode.toggledOn;

              if (start != null && end != null) {
                scheduleList = getScheduleForRange(start, end);
              }
            });
          },

          /// 🔥 SINGLE DAY SELECT
          onDaySelected: (selected, focused) {
            setState(() {
              selectedDay = selected;
              focusedDay = focused;

              /// Disable range mode when selecting single day
              rangeSelectionMode = RangeSelectionMode.toggledOff;
              rangeStart = null;
              rangeEnd = null;

              String? holiday = getHolidayName(selected);
              List<String> events = getEventsForDay(selected);

              // if (holiday != null) {
              //   selectedDayMessage = "This date is $holiday holiday";
              // } else if (events.isNotEmpty) {
              //   selectedDayMessage = "This date has ${events.join(', ')} event";
              // } else {
              //   // selectedDayMessage = "No events on this day";
              // }

              /// Schedule View for single day
              scheduleList = [];
              if (holiday != null) scheduleList.add("Holiday: $holiday");
              if (events.isNotEmpty) {
                scheduleList.add("Events: ${events.join(', ')}");
              }
            });
          },

          eventLoader: getEventsForDay,
          holidayPredicate: (day) => isHoliday(day),

          calendarStyle: CalendarStyle(
            rangeStartDecoration: BoxDecoration(
              color: widget.rangeStartColor,
              shape: BoxShape.circle,
            ),
            rangeEndDecoration: BoxDecoration(
              color: widget.rangeEndColor,
              shape: BoxShape.circle,
            ),
            todayDecoration: BoxDecoration(
              color: widget.todaySelectColor,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: widget.holidaySelectColor,
              shape: BoxShape.circle,
            ),
            holidayDecoration: BoxDecoration(
              color: widget.holidayBackGroundColor,
              shape: BoxShape.circle,
              border: Border.all(color: widget.holidayBorderColor),
            ),
            markerDecoration: BoxDecoration(
              color: widget.eventSelectColor,
              shape: BoxShape.circle,
            ),
          ),
        ),

        ElevatedButton(
          onPressed: selectTime,
          style: widget.buttonStyle,
          child: Text(widget.timeSelectButtonText ?? 'Select Time'),
        ),

        const Divider(),

        /// 🔥 Selected Day Message
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     selectedDayMessage,
        //     style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        //
        // const Divider(),

        /// 🔥 Schedule View Section
         Text(
          widget.scheduleText ?? 'Schedule View',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        SizedBox(
          height: 150,
          child: ListView.builder(
            itemCount: scheduleList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.event),
                title: Text(scheduleList[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
