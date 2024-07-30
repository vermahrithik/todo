import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: Container(
                      width: deviceWidth * 0.8,
                      height: 37,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.grey.shade500,
                        // controller: searchController,
                        // onChanged: (){},
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 14.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade400,
                            ),
                          ),
                          fillColor: Colors.transparent,
                          filled: true,
                          hintText: 'Enter Task to Update',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade800.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    title: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Update Task \n"Task 01"',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // content: Text('This is the content of the alert dialog.'),
                    elevation: 4,
                    actionsAlignment: MainAxisAlignment.end,
                    actions: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: deviceWidth * 0.2,
                          height: deviceHeight * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text("Cancel"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Updated Successfully !',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500),),
                                backgroundColor: Colors.blue,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // margin: EdgeInsets.all(10),
                                width: deviceWidth*0.6,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          width: deviceWidth * 0.2,
                          height: deviceHeight * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Center(
                            child: Text("Update"),
                          ),
                        ),
                      ),
                    ],
                  ));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(8)),
          height: deviceHeight * 0.1,
          width: deviceWidth * 0.95,
          child: Center(
              child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Checkbox(
                value: _isChecked,
                side: WidgetStateBorderSide.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.selected)) {
                      return const BorderSide(
                          color: Colors
                              .transparent); // Transparent border when checked
                    }
                    return BorderSide(
                        color: Color(0xff00FFB8),
                        width: 2); // Custom border color when unchecked
                  },
                ),
                activeColor: Colors.transparent,
                checkColor: Colors.indigo,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "Lorem Ipsum",
                style: TextStyle(
                  decoration: _isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
