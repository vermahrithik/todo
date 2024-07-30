import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/task.dart';
import 'package:todo/taskModel.dart';
import 'package:todo/taskModel.dart';
import 'package:todo/taskSearch.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController taskController = TextEditingController();
  TextEditingController taskNoteController = TextEditingController();
  List<TaskModel> tasks = List.empty(growable: true);
  bool _isChecked = false;
  int selectedIndex = -1;

  late SharedPreferences sp;

  @override
  void initState() {
    super.initState();
    getSharedPrefrences();
  }

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  saveIntoSp() {

    List<String> taskListString = tasks.map((task)=>jsonEncode(task.toJson())).toList();
    sp.setStringList("data", taskListString);

  }

  readFromSp() {

    List<String>? taskListString = sp.getStringList("data");

    if(taskListString!=null){
      tasks= taskListString.map((task)=>TaskModel.fromJson(json.decode(task))).toList();
    }

    setState(() {

    });

  }



  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(
            deviceWidth,deviceHeight*0.1
        ),
        child: SizedBox(height: deviceHeight*0.05,),
      ),
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: Center(
          child: tasks.isNotEmpty ?
          ListView.builder(
              itemCount: tasks.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      selectedIndex = index;
                      taskController.text = tasks[index].task!;
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Container(
                              width: deviceWidth * 0.8,
                              height: 40,
                              child: Text('Are you sure,\nyou want to delete this task ?'),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: Colors.white,
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Delete : Task ${index + 1}',
                                textAlign: TextAlign.left,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            elevation: 4,
                            actionsAlignment: MainAxisAlignment.end,
                            actions: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    taskController.text = "";
                                  });
                                },
                                child: Container(
                                  width: deviceWidth * 0.2,
                                  height: deviceHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    tasks.removeAt(index);
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'Deleted Successfully !',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        width: deviceWidth * 0.6,
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  });
                                  saveIntoSp();
                                },
                                child: Container(
                                  width: deviceWidth * 0.2,
                                  height: deviceHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    });
                  },
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                      taskController.text = tasks[index].task!;
                      taskNoteController.text = tasks[index].taskNote!;
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Container(
                              width: deviceWidth * 0.8,
                              height: 110,
                              child: Column(
                                children: [
                                  TextField(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    cursorColor: Colors.grey.shade500,
                                    controller: taskController,
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
                                  SizedBox(height: 8,),
                                  TextField(
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    cursorColor: Colors.grey.shade500,
                                    controller: taskNoteController,
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
                                      hintText: 'Enter Task Description to Update',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade800.withOpacity(0.8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: Colors.white,
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Update Task \n"Task ${index + 1}"',
                                textAlign: TextAlign.left,
                              ),
                            ),
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
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  String newTask = taskController.text.trim();
                                  String newNote = taskNoteController.text.trim();
                                  if (newTask.isNotEmpty && newNote.isNotEmpty) {
                                    setState(() {
                                      tasks[selectedIndex].task = newTask;
                                      tasks[selectedIndex].taskNote = newNote;
                                      taskController.text = '';
                                      selectedIndex = -1;
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: const Text(
                                            'Updated Successfully !',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          backgroundColor: Colors.amber.shade400,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          width: deviceWidth * 0.6,
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    });
                                    saveIntoSp();
                                  }
                                },
                                child: Container(
                                  width: deviceWidth * 0.2,
                                  height: deviceHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.amber.shade400,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Update",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        dismissible:DismissiblePane(
                            onDismissed: () {
                              setState(() {
                                tasks.removeAt(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Deleted Successfully !',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: deviceWidth * 0.6,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                              saveIntoSp();
                            }
                        ),
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 1,
                            onPressed: (_){},
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            label: 'Swipe Right to Delete',
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        dismissible:DismissiblePane(
                            onDismissed: () {
                              setState(() {
                                tasks.removeAt(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Deleted Successfully !',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    width: deviceWidth * 0.6,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              });
                              saveIntoSp();
                            }
                        ),
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            // An action can be bigger than the others.
                            flex: 1,
                            onPressed: (_){},
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            label: 'Swipe Left to Delete',
                          ),
                        ],
                      ),
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: deviceHeight * 0.1,
                        width: deviceWidth * 0.95,
                        child: Center(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8,
                                ),
                                Checkbox(
                                  value: tasks[index].isChecked,
                                  side: WidgetStateBorderSide.resolveWith(
                                        (states) {
                                      if (states.contains(WidgetState.selected)) {
                                        return const BorderSide(
                                            color: Colors.transparent); // Transparent border when checked
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
                                      tasks[index].isChecked = value!;
                                    });
                                    saveIntoSp();
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tasks[index].task.toString().toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,

                                        decoration: tasks[index].isChecked
                                            ? (TextDecoration.lineThrough)
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    Text(
                                      tasks[index].taskNote.toString(),
                                      style: TextStyle(
                                        decoration: tasks[index].isChecked
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                        overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                );
              }
          ): const Center(
            child: Text('add tasks to show'),
          ),
        ),
      ),
      bottomNavigationBar: TaskSearch(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: (){
          setState(() {
            taskController.text="";
            taskNoteController.text="";
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Container(
                  width: deviceWidth * 0.8,
                  height: 110,
                  child: Column(
                    children: [
                      TextField(
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.grey.shade500,
                        controller: taskController,
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
                          hintText: 'Enter Task',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade800.withOpacity(0.8),
                          ),
                        ),
                      ),
                      SizedBox(height: 8,),
                      TextField(
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                        cursorColor: Colors.grey.shade500,
                        controller: taskNoteController,
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
                          hintText: 'Enter Task Description',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade800.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                alignment: Alignment.center,
                backgroundColor: Colors.white,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add New Task',
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
                        // color: Colors.black.withOpacity(0.1),
                      ),
                      child: Center(
                        child: Text("Cancel",style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String newTask = taskController.text.trim();
                      String newNote = taskNoteController.text.trim();
                      if(newTask.isNotEmpty && newNote.isNotEmpty){
                        setState(() {
                          tasks.add(TaskModel(task: newTask,taskNote: newNote));
                          taskController.text = '';
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Added Successfully !',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // margin: EdgeInsets.all(10),
                              width: deviceWidth*0.6,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                        saveIntoSp();
                      }else{
                        print("Please Enter the details to add task");
                        setState(() {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Please enter the details !',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500),),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // margin: EdgeInsets.all(10),
                              width: deviceWidth*0.6,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        });
                      }
                    },
                    child: Container(
                      width: deviceWidth * 0.2,
                      height: deviceHeight * 0.05,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: Center(
                        child: Text("Add",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ),
                ],
              )
            );
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.blue,
        ),
        backgroundColor: Colors.white,
        elevation: 4,
      )
    );
  }
}
