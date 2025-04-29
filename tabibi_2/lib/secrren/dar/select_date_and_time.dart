import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabibi_2/app/providers/appointment_provider.dart';
import 'package:tabibi_2/secrren/dar/payment .dart';
import 'package:table_calendar/table_calendar.dart';

class SelectDateAndTime extends StatefulWidget {
  SelectDateAndTime({Key? key}) : super(key: key);

  @override
  State<SelectDateAndTime> createState() => _SelectDateAndTimeState();
}

class _SelectDateAndTimeState extends State<SelectDateAndTime> {
  DateTime? selectedDate;
  String? selectedTimeSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date And Time'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2023, 1, 1),
              lastDay: DateTime.utc(2023, 12, 31),
              focusedDay: DateTime.now().isBefore(DateTime.utc(2023, 12, 31)) &&
                      DateTime.now().isAfter(DateTime.utc(2023, 1, 1))
                  ? DateTime.now()
                  : DateTime.utc(2023, 1, 1),
              calendarFormat: CalendarFormat.month,
              headerStyle: HeaderStyle(formatButtonVisible: false),
              selectedDayPredicate: (day) => selectedDate != null && isSameDay(selectedDate!, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  selectedDate = selectedDay;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Available Time Slot',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedTimeSlot = '10:00'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTimeSlot == '10:00' ? Theme.of(context).primaryColor : null,
                  ),
                  child: Text('10:00 AM'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTimeSlot = '11:00'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTimeSlot == '11:00' ? Theme.of(context).primaryColor : null,
                  ),
                  child: Text('11:00 AM'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTimeSlot = '12:00'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedTimeSlot == '12:00' ? Theme.of(context).primaryColor : null,
                  ),
                  child: Text('12:00 PM'),
                ),
              ],
            ),
            Spacer(),
            // Display selected date and time
            if (selectedDate != null || selectedTimeSlot != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Selected: ${selectedDate?.toString().split(' ')[0]} at $selectedTimeSlot',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            
            Center(
              child: Consumer<AppointmentProvider>(
                builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator();
                  }
                  
                  if (provider.error != null) {
                    return Column(
                      children: [
                        Text(
                          provider.error!,
                          style: TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () => _createAppointment(provider),
                          child: Text('Retry'),
                        ),
                      ],
                    );
                  }

                  return ElevatedButton(
                    onPressed: () => _createAppointment(provider),
                    child: Text('Set Appointment'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createAppointment(AppointmentProvider provider) async {
    if (selectedDate == null || selectedTimeSlot == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both date and time')),
      );
      return;
    }

    // For testing purposes, using dummy values
    final startTime = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      int.parse(selectedTimeSlot!.split(':')[0]),
    );
    final endTime = startTime.add(Duration(hours: 1));

    final success = await provider.createAppointment(
      workScheduleId: "test-schedule-id", // TODO: Use real workScheduleId
      patientId: "test-patient-id", // TODO: Use real patientId
      startTime: startTime,
      endTime: endTime,
    );

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Payment()),
      );
    }
  }
}
