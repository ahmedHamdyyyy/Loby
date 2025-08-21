// Calendar header with navigation
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/colors/colors.dart';

// Calendar widget
class CalendarSection extends StatefulWidget {
  const CalendarSection({super.key, required this.selectedDates, required this.onDatesChanged});
  final Function(Set<DateTime>) onDatesChanged;
  final Set<DateTime> selectedDates;
  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection> {
  final Set<DateTime> _selectedDates = {};
  DateTime _currentMonth = DateTime.now();
  @override
  void initState() {
    _selectedDates.addAll(widget.selectedDates);
    super.initState();
  }

  String _getMonthName(int month) =>
      [
        'January',
        'February',
        'March',
        'April',
        'May',
        'June',
        'July',
        'August',
        'September',
        'October',
        'November',
        'December',
      ][month - 1];

  void _previousMonth() => setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1));

  void _nextMonth() => setState(() => _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1));

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _selectDate(DateTime date) {
    setState(() {
      if (_selectedDates.contains(date)) {
        _selectedDates.remove(date);
      } else {
        _selectedDates.add(date);
      }
    });
    widget.onDatesChanged(_selectedDates);
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${_getMonthName(_currentMonth.month)} ${_currentMonth.year}",
              style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _previousMonth,
                  icon: const Icon(Icons.chevron_left, color: AppColors.primaryColor),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: _nextMonth,
                  icon: const Icon(Icons.chevron_right, color: AppColors.primaryColor),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(color: Color(0xFFCBCBCB)),
        const SizedBox(height: 16),
        // Selected dates summary
        if (_selectedDates.isNotEmpty) ...[
          Text(
            'Selected Dates (${_selectedDates.length}):',
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                _selectedDates.map((date) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withAlpha(25),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${date.day}/${date.month}/${date.year}',
                          style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primaryColor),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _selectDate(date),
                          child: const Icon(Icons.close, size: 16, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFCBCBCB)),
          const SizedBox(height: 16),
        ],
        // Calendar days of week header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              const ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'].map((day) {
                return SizedBox(
                  width: 35,
                  child: Center(
                    child: Text(
                      day,
                      style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grayTextColor),
                    ),
                  ),
                );
              }).toList(),
        ),
        const SizedBox(height: 8),
        // Calendar grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemCount: 42, // 6 rows of 7 days
          itemBuilder: (context, index) {
            final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
            final firstDayOffset = firstDay.weekday % 7;
            final displayIndex = index - firstDayOffset;
            final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
            final isCurrentMonth = displayIndex >= 0 && displayIndex < daysInMonth;
            final day =
                isCurrentMonth
                    ? displayIndex + 1
                    : displayIndex < 0
                    ? DateTime(_currentMonth.year, _currentMonth.month, 0).day + displayIndex + 1
                    : displayIndex - daysInMonth + 1;
            final date =
                isCurrentMonth
                    ? DateTime(_currentMonth.year, _currentMonth.month, day)
                    : displayIndex < 0
                    ? DateTime(_currentMonth.year, _currentMonth.month - 1, day)
                    : DateTime(_currentMonth.year, _currentMonth.month + 1, day);
            final isSelected = _selectedDates.any((selectedDate) => _isSameDay(selectedDate, date));
            final isPastDate = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));
            final onTap = (isCurrentMonth && !isPastDate) ? () => _selectDate(date) : null;
            final isEnabled = !isPastDate && onTap != null;
            return GestureDetector(
              onTap: isEnabled ? onTap : null,
              child: Container(
                height: 35,
                width: 35,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primaryColor : null,
                  border: isSelected ? null : Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  day.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color:
                        !isCurrentMonth
                            ? Colors.grey.withAlpha(75)
                            : isPastDate
                            ? Colors.grey.withAlpha(75)
                            : isSelected
                            ? Colors.white
                            : AppColors.primaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

