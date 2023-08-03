import 'package:astro_santhil_app/models/add_appointment_model.dart';
import 'package:astro_santhil_app/networking/services.dart';
import 'package:astro_santhil_app/view/appointment.dart';
import 'package:astro_santhil_app/view/category_managmet.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
class CustomDialog extends StatefulWidget {
  final DateTime initialDate;
  final TimeOfDay initialStartTime;
  final TimeOfDay initialEndTime;
  final String title;
  final String slot_id;
  final bool isshow;

  CustomDialog({
    required this.isshow,
    required this.title,
    required this.slot_id,
    required this.initialDate,
    required this.initialStartTime,
    required this.initialEndTime,
  });
  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    isDateshow=widget.isshow;
    isStartshow=widget.isshow;
    isEndshow=widget.isshow;
    selectedDate = widget.initialDate ?? DateTime.now();
    selectedStartTime = widget.initialStartTime ?? TimeOfDay.now();
    selectedEndTime = widget.initialEndTime ?? TimeOfDay.now();
  }

  bool isDateshow=false;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child){
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        isDateshow=true;
        selectedDate = picked;
      });
    }
  }

  bool isStartshow=false;
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime,
      builder: (BuildContext context, Widget? child){
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        isStartshow=true;
        selectedStartTime = picked;
      });
    }
  }

  bool isEndshow=false;
  String startdate="";
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
      builder: (BuildContext context, Widget? child){
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor:Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        isEndshow=true;
        selectedEndTime = picked;
      });
    }
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dateTime);
  }


  late AddAppointmentModel _addAppointmentModel;
  bool clickLoad=false;
  void AddAppointment(String date,fromtime,totime)async{
    setState(() {
      clickLoad = true;
    });
    _addAppointmentModel = await Services.addAppointment2(
      date,
      fromtime,
      totime,
    );

    if (_addAppointmentModel.status == true) {
      Fluttertoast.showToast(
          msg: "${_addAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CategoryManagement(),
      ));
      // Navigator.of(context).pop();
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => Appointment("today")));
    } else {
      Fluttertoast.showToast(
          msg: "${_addAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {
      clickLoad = false;
    });
  }

  void EditAppointment(String date,fromtime,totime)async{
    setState(() {
      clickLoad = true;
    });
    _addAppointmentModel = await Services.EditAppointment2(
        date,
        fromtime,
        totime,
        widget.slot_id
    );

    if (_addAppointmentModel.status == true) {
      Fluttertoast.showToast(
          msg: "${_addAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CategoryManagement(),
      ));
      // Navigator.of(context).pop();
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => Appointment("today")));
    } else {
      Fluttertoast.showToast(
          msg: "${_addAppointmentModel.msg}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR);
    }
    setState(() {
      clickLoad = false;
    });
  }





  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('${widget.title} Slot'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(isDateshow==false?"Select Date":"${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",style: TextStyle(color: Colors.black),),
            // child: Text('Select Date' ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _selectStartTime(context),
            // child: Text('Select Start Time'),
            child: Text(isStartshow==false?"Select Start Time":"${formatTimeOfDay(selectedStartTime)}",style: TextStyle(color: Colors.black)),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _selectEndTime(context),
            child: Text(isEndshow==false ? "Select End Time":"${formatTimeOfDay(selectedEndTime)}",style: TextStyle(color: Colors.black)),
            // child: Text('Select End Time'),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if(isDateshow==false){
              Fluttertoast.showToast(
                  msg: "Select date",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR);
            }else if(isStartshow==false){
              Fluttertoast.showToast(
                  msg: "Select start time",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR);
            }else if(isStartshow==false){
              Fluttertoast.showToast(
                  msg: "Select end time",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR);
            }else{
              if(widget.title=="Add"){
                AddAppointment(
                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                    "${formatTimeOfDay(selectedStartTime)}",
                    "${formatTimeOfDay(selectedEndTime)}");
                // Navigator.of(context).pop();
              }else{
                EditAppointment(
                    "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                    "${formatTimeOfDay(selectedStartTime)}",
                    "${formatTimeOfDay(selectedEndTime)}");
              }
            }
          },
          child: Text('Done',style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}