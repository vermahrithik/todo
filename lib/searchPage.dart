import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'taskModel.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  List<TaskModel> showtasks = List.empty(growable: true);
  List<TaskModel> filteredTasks = List.empty(growable: true);

  late SharedPreferences sp;

  // @override
  // void initState() {
  //   super.initState();
  //   getSharedPrefrences();
  // }

  List<TaskModel> _foundTasks = [];
  @override
  initState(){
    getSharedPrefrences();
    super.initState();
  }

  getSharedPrefrences() async {
    sp = await SharedPreferences.getInstance();
    readFromSp();
  }

  readFromSp() {
    List<String>? taskListString = sp.getStringList("data");
    if (taskListString != null) {
      showtasks = taskListString
          .map((task) => TaskModel.fromJson(json.decode(task)))
          .toList();
      _foundTasks = showtasks;
    }
    setState(() {});
  }

  saveIntoSp() {
    List<String> taskListString =
    showtasks.map((task) => jsonEncode(task.toJson())).toList();
    sp.setStringList('Products', taskListString);
  }

  // void searchTasks(String query) {
  //   if (query.isEmpty) {
  //     filteredTasks = showtasks;
  //   } else {
  //     filteredTasks = showtasks.where((task) =>
  //     task.task?.contains(query) ?? false).toList();
  //
  //   }
  //   setState(() {});
  // }
  void searchTasks(String query) {
    if (query.isEmpty) {
      _foundTasks = showtasks;
    } else {
      _foundTasks = showtasks.where((task) =>
      task.task?.contains(query) ?? false).toList();

    }
    setState(() {});
  }
  

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.grey.shade500,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(color: Colors.grey.shade400, width: 1),
                        ),
                        child: const Icon(CupertinoIcons.back, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                titleSpacing: 0,
                centerTitle: true,
                title: Container(
                  width: deviceWidth * 0.8,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: Colors.grey.shade500,
                    controller: searchController,
                    onChanged: searchTasks,
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
                      hintText: 'Search Task',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade800.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),
                backgroundColor: Colors.grey.shade500,
              ),
            ],
          ),
        ),
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          child: Center(
            child: _foundTasks.isNotEmpty ?
            ListView.builder(
                itemCount: _foundTasks.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        height: deviceHeight * 0.1,
                        width: deviceWidth * 0.95,
                        child: Center(
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (_foundTasks[index].task ?? 'Unknown').toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      (_foundTasks[index].taskNote??'Unknown'),
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),

                  );
                }
            ): const Center(
              child: Text('add tasks to show'),
            ),
          ),
        ),
    );
  }

  void _fetchData() {
    readFromSp();
  }
}
