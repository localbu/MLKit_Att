import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:students_attendance_with_mlkit/ui/components/custom_snackbar.dart';
import 'package:students_attendance_with_mlkit/ui/home_screen.dart';

class AbsentScreen extends StatefulWidget {
  const AbsentScreen({super.key});

  @override
  State<AbsentScreen> createState() => _AbsentScreenState();
}

class _AbsentScreenState extends State<AbsentScreen> {
  String? strAlamat, strDate, strTime, strDateTime;
  double dlat = 0.0, dlong = 0.0;
  int dateHours = 0, dateMinutes = 0;

  final controllerName = TextEditingController();
  final controllerTo = TextEditingController();
  final controllerFrom = TextEditingController();

  String dropValueCategory = "please select";
  List<String> category = [
    "please select",
    "other",
    "pemrmission",
    "sick",
  ];

  final CollectionReference dataCollection =
      FirebaseFirestore.instance.collection('attendance');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF44FF70),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Permission Request Menu',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.fromLTRB(
            10,
            10,
            10,
            30,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Colors.white,
          elevation: 5,
          child: Column(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: const Color(0xFF44FF70),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Icon(
                      Icons.maps_home_work_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      "please fill the form",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: TextField(
                  controller: controllerName,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    labelText: "Your Name",
                    labelStyle:
                        TextStyle(fontSize: 14, color: const Color(0xFF44FF70)),
                    hintText: "Please Enter Your Name",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: const Color(0xFF44FF70),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: const Color(0xFF44FF70),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Description",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF44FF70),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF44FF70),
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: DropdownButton(
                    dropdownColor: Colors.white,
                    value: dropValueCategory,
                    items: category.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    isExpanded: true,
                    onChanged: (String? value) {
                      setState(() {
                        dropValueCategory = value!;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Text("Form:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF44FF70))),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedData = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2026),
                                    initialDate: DateTime.now(),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                      onPrimary: Colors.white,
                                                      onSurface:
                                                          const Color(0xFF44FF70),
                                                      primary:
                                                          const Color(0xFF44FF70)),
                                              datePickerTheme:
                                                  const DatePickerThemeData(
                                                      headerBackgroundColor:
                                                          const Color(0xFF44FF70),
                                                      backgroundColor:
                                                          Colors.white,
                                                      headerForegroundColor:
                                                          Colors.white,
                                                      surfaceTintColor:
                                                          Colors.white)),
                                          child: child!);
                                    });

                                if (pickedData != null) {
                                  controllerFrom.text = DateFormat('dd/MM/yyy')
                                      .format(pickedData);
                                }
                              },
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                              controller: controllerFrom,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Starting Form',
                                hintStyle: TextStyle(
                                    color: const Color(0xFF44FF70), fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const Text("Until:",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF44FF70))),
                          Expanded(
                            child: TextField(
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedData = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2024),
                                    lastDate: DateTime(2026),
                                    initialDate: DateTime.now(),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Theme(
                                          data: Theme.of(context).copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                      onPrimary: Colors.white,
                                                      onSurface:
                                                          const Color(0xFF44FF70),
                                                      primary:
                                                          const Color(0xFF44FF70)),
                                              datePickerTheme:
                                                  const DatePickerThemeData(
                                                      headerBackgroundColor:
                                                          const Color(0xFF44FF70),
                                                      backgroundColor:
                                                          Colors.white,
                                                      headerForegroundColor:
                                                          Colors.white,
                                                      surfaceTintColor:
                                                          Colors.white)),
                                          child: child!);
                                    });

                                if (pickedData != null) {
                                  controllerTo.text = DateFormat('dd/MM/yyy')
                                      .format(pickedData);
                                }
                              },
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                              controller: controllerTo,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(8),
                                hintText: 'Ending Until',
                                hintStyle: TextStyle(
                                    color: const Color(0xFF44FF70), fontSize: 16),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(30),
                child: Material(
                  elevation: 3,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF44FF70),
                      child: InkWell(
                        splashColor: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          if (controllerName.text.isEmpty ||
                              controllerFrom.text.isEmpty ||
                              controllerTo.text.isEmpty ||
                              dropValueCategory == "please select") {
                            customSnackbar(context, Icons.info_outline,
                                "Ups, please fill the form!");
                          } else {
                            submitAbsen(
                              "-",
                              controllerName.text,
                              dropValueCategory,
                              controllerFrom.text,
                              controllerTo.text,
                            );
                          }
                        },
                        child: Center(
                          child: Text(
                            "make a request",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF44FF70)),
          ),
          SizedBox(width: 10),
          Text('Checking data...')
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void submitAbsen(String? strAlamat, String name, String? strStatus,
      String from, String until) {
    dataCollection.add({
      "address": strAlamat,
      "name": name,
      "starus": strStatus,
      "dateTime": "$from - $until",
    }).then((result) {
      setState(() {
        Navigator.pop(context);
        try {
          customSnackbar(context, Icons.check_circle_outline, "Succes");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        } catch (e) {
          customSnackbar(context, Icons.error_outline, e.toString());
        }
      });
    }).catchError((error) {
      customSnackbar(context, Icons.error_outline, error.toString());
    });
  }
}
