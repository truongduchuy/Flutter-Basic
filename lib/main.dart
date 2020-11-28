import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './list_item.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
    ));

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List list = ['1', '2', '3'];
  var value;

  deleteItem(item) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Text('Are you sure to delete?'),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                FlatButton(
                    child: Text('Delete'),
                    onPressed: () {
                      setState(() {
                        list.remove(item);
                        Navigator.of(context).pop();
                      });
                    })
              ]);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  addItem() async {
    var newValue = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Positioned(
                    right: -40.0,
                    top: -40.0,
                    child: InkResponse(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: CircleAvatar(
                        child: Icon(Icons.close),
                        backgroundColor: Colors.red[600],
                      ),
                    ),
                  ),
                  Form(
                    // key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            autofocus: true,
                            onChanged: (newValue) {
                              setState(() {
                                value = newValue;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                              child: Text("Submit"),
                              onPressed: value == null || value.isEmpty
                                  ? null
                                  : () {
                                      setState(() {
                                        Navigator.of(context).pop(value);
                                      });
                                    }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
        });
    setState(() {
      list.add(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('To Do List'),
            centerTitle: true,
            backgroundColor: Colors.blue[600]),
        body: Container(
            padding: EdgeInsets.all(5),
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListItem(deleteItem: deleteItem, item: list[index]);
                })),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => addItem(),
          label: Text('Add'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ));
  }
}

