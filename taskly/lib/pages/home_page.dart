import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskly/models/task.dart';


class HomePage extends StatefulWidget{
  HomePage();

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }

}

class _HomePageState extends State<HomePage>{

  late double _deviceWidth,_deviceHeight;
  String? _newTaskContent;

  Box? _box;

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text('Taskly!',style: TextStyle(fontSize: 25,color: Colors.white),),
      ),
      body: _tasksView(),
      floatingActionButton: _floatingActionButton(),
    );
  }

Widget _tasksView() {
    return FutureBuilder(
      future: Hive.openBox('tasks'),
      builder: (BuildContext _context, AsyncSnapshot _snapshot) {
        if (_snapshot.hasData) {
          _box=_snapshot.data;
          return _taskList();
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _taskList(){
    List tasks=_box!.values.toList();
    return ListView.builder(itemCount: tasks.length,itemBuilder: (BuildContext _context,int _index) {
      var task =Task.fromMap(tasks[_index]);
      return  ListTile(
          title:  Text(task.content,style: TextStyle( decoration: task.done?TextDecoration.lineThrough:null),),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(task.done?Icons.check_box_outlined:Icons.check_box_outline_blank_outlined,color: Colors.red,),
          onTap: () {
            task.done =!task.done;
            _box!.putAt(_index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box!.deleteAt(_index);
            setState(() {});
          },
        );
    });
  }

  Widget _floatingActionButton(){
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(Icons.add),
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (BuildContext _context) {
        return AlertDialog(
          title: const Text("Add New Task!"),
          content: TextField(
            onSubmitted: (_) {
              if(_newTaskContent!=null){
                _box!.add(Task(content: _newTaskContent!,done: false,timestamp: DateTime.now()).toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.of(_context).pop();
                });
              }
            },
            onChanged: (_value) {
              setState(() {
                _newTaskContent = _value;
              });
            },
          ),
        );
      },
    );
  }
}