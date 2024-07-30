import 'package:flutter/material.dart';
import 'package:todo/searchPage.dart';

class TaskSearch extends StatefulWidget {
  const TaskSearch({super.key});

  @override
  State<TaskSearch> createState() => _TaskSearchState();
}

class _TaskSearchState extends State<TaskSearch> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      height: deviceHeight*0.1,
      width: double.infinity,
      color: Colors.white,
      child: Center(
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 12,),
                    Icon(Icons.menu,color: Colors.blue,),
                    SizedBox(width: 10,),
                    Text(
                      "Todo",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),
                    ),

                  ],
                )
              ),
              Expanded(
                flex: 1,
                child:Center(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>SearchPage()),
                      );
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}
