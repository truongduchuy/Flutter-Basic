import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  String item;
  Function deleteItem;

  ListItem({this.item, this.deleteItem});

  @override
  Widget build(BuildContext context) {
    return Card(
          child: Container(
        padding: EdgeInsets.only(left: 20),
          child:  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(item, style: TextStyle(fontSize: 20)),
          IconButton(icon: Icon(Icons.delete), onPressed: () => deleteItem(item))
        ]),
      ),
    );
  }
}
