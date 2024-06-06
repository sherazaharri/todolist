import 'package:flutter/material.dart';
import 'entry_card.dart';
import 'task.dart';
import 'package:posthog_flutter/posthog_flutter.dart';


void main() {
  runApp(MaterialApp(
    home: ToDoList(),
  ));
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  var newTask;
  var newDate;
  var taskList = Task.tasklist();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Color(0xFF528774),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/greenlock.png", height: 60)
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Task",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Lucida Sans Unicode"
                  ),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  onChanged: (Task){
                    setState((){
                      newTask = Task;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Add Task", hintStyle: TextStyle(
                      fontFamily: "Lucida Sans Unicode"
                  ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      )
                  ),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  onChanged: (Date){
                    setState((){
                      newDate = Date;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Add Date", hintStyle: TextStyle(
                      fontFamily: "Lucida Sans Unicode"
                  ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      )
                  ),
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: ()async {
                        await Posthog().capture(
                        eventName: 'add_task_button_clicked',);
                        setState(() {
                          taskList.add(Task(dueDate: newDate, todoText: newTask));
                        });
                      },
                      child: Text("Add Task"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: BorderSide(width: 2.0, color: Colors.blue)
                      ),
                  ),
                ]),
                Divider(
                  height: 20,
                ),
                Text("Current Tasks",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Lucida Sans Unicode"
                  ),
                ),
                for(Task tasklist in taskList)
                  entryCard(taskFinal: tasklist, delete: (){
                    setState(() {
                      taskList.remove(tasklist);
                    });
                  },)
              ],
            ),
          ),
        )
    );
  }
}
