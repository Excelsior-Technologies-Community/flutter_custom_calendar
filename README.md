# 📅 Custom Calendar for Flutter

A fully customizable Calendar + Range Picker + Schedule View + Time Picker widget built using table_calendar.

This widget supports:
- ✔ Single-day selection
- ✔ Range selection
- ✔ Event markers
- ✔ Holiday indicators
- ✔ Custom colors
- ✔ Schedule view
- ✔ Time picker integration

## 🚀 Features
🔹 Single Day Picker

Select a single date and view events & holidays for that day.

🔹 Range Date Picker

Select a start and end date — schedule list auto-generates for the whole range.

🔹 Event Support

Attach multiple events to any date.

🔹 Holiday Support

Add holidays with custom decoration.

🔹 Schedule View

Shows selected day's or date range’s complete schedule.

🔹 Time Picker Button

Built-in customizable time picker button.

🔹 Fully Customizable

Colors, borders, schedule text, and button styles.

## 📦 Installation
Add dependency in your pubspec.yaml:
```
dependencies:
    custom_calendar:
      path: ".../flutter_custom_calendar/custom_calendar" # your path
```
from git:
```
dependencies:
  custom_calendar:
    git:
      url: https://github.com/yourusername/flutter_custom_calendar/custom_calendar.git
```
## 🛠 How to Use
1️⃣ Import the library
```
import 'package:custom_calendar/custom_calendar.dart';
```
2️⃣ Example Usage
```
CustomCalendar(
  events: {
    DateTime(2025, 1, 15): ["Meeting"],
    DateTime(2025, 1, 20): ["Birthday"],
  },

  holidays: {
    DateTime(2025, 1, 26): "Republic Day",
    DateTime(2025, 8, 15): "Independence Day",
  },

  holidaySelectColor: Colors.blue,
  holidayBackGroundColor: Colors.yellow,
  holidayBorderColor: Colors.deepOrange,
  eventSelectColor: Colors.red,
  todaySelectColor: Colors.orange,
  rangeStartColor: Colors.green,
  rangeEndColor: Colors.green,

  timeSelectButtonText: "Select Time",
  scheduleText: "Your Schedule",
)
```
## 🎨 Customizable Properties
| Property                 | Description                      |
| ------------------------ | -------------------------------- |
| `events`                 | Map of event lists for each date |
| `holidays`               | Map of holiday names             |
| `holidaySelectColor`     | Color for selected holiday       |
| `holidayBackGroundColor` | Background of holiday date       |
| `holidayBorderColor`     | Border around holiday day        |
| `eventSelectColor`       | Color of event dots              |
| `todaySelectColor`       | Color for today’s highlight      |
| `rangeStartColor`        | Color for start date of range    |
| `rangeEndColor`          | Color for end date of range      |
| `timeSelectButtonText`   | Label for time picker button     |
| `buttonStyle`            | Custom button style              |
| `scheduleText`           | Header text for schedule view    |

## 📌 Output Preview
https://github.com/user-attachments/assets/ea3a6fb8-952b-4cc9-98cf-db1fb26ba28e
## 📜 License
MIT License
```
Copyright (c) 2025 Excelsior Technologies

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED **"AS IS"**, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.

