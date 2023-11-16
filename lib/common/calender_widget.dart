import 'package:flutter/material.dart';
import '../../../common/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'app_font_size.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.white, borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat("MMM, yyyy").format(_focusedDay),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: FontSize.header_4(context),
                    color: AppColor.black),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month - 1);
                      });
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColor.black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _focusedDay =
                            DateTime(_focusedDay.year, _focusedDay.month + 1);
                      });
                    },
                    child: const Icon(
                      Icons.chevron_right,
                      color: AppColor.black,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2040),
            headerVisible: false,
            onFormatChanged: (result) {},
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) {
                return DateFormat("EEE").format(date).toUpperCase();
              },
              weekendStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 14,
              ),
              weekdayStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.black,
                fontSize: 14,
              ),
            ),
            onPageChanged: (day) {
              _focusedDay = day;
              setState(() {});
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColor.grey,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: AppColor.grey,
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(
                color: AppColor.black,
              ),
            ),
            eventLoader: (day) {
              /// Make event on 22 and 12 date every month
              if (day.day == 22 || day.day == 12) {
                return [Event("Event Name", canBubble: true)];
              }
              return [];
            },
          )
        ],
      ),
    );
  }
}

class Event {
  final String name;
  final bool canBubble;

  Event(this.name, {this.canBubble = false});
}
