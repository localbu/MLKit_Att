import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:students_attendance_with_mlkit/ui/absent/absent_screen.dart';
import 'package:students_attendance_with_mlkit/ui/attend/attend_screen.dart';
import 'package:students_attendance_with_mlkit/ui/attendance_history/attendance_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _onwillPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AttendScreen())),
                      child: Column(
                      children: [
                        Image.asset('assets/images/ic_leave.png',
                            width: 100, height: 100),
                        SizedBox(height: 10),
                        Text(
                          'Students Attendance',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    )
                  ),
                ),
                
                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AbsentScreen())),
                      child: Column(
                      children: [
                        Image.asset('assets/images/ic_absen.png',
                            width: 100, height: 100),
                        SizedBox(height: 10),
                        Text(
                          'Absent / Permission',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    )
                  ),
                ),

                SizedBox(height: 40),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Expanded(
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceHistoryScreen())),
                      child: Column(
                      children: [
                        Image.asset('assets/images/ic_history.png',
                            width: 100, height: 100),
                        SizedBox(height: 10),
                        Text(
                          'Attendance History',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    )
                  ),
                ),
              ],
            ),
          )
        ),
      )
    );
  }
  Future<bool> _onwillPop(BuildContext context) async {
    return (await showDialog(
      context: context,
      builder: (context) => 
      AlertDialog(
        title: Text(
          'INFO',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),
        content: Text(
          'Are you sure you want to exit?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), 
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(), 
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    ) ?? false);
  }
}