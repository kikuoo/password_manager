import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'Pass.dart';

int keyed;
class PassEdit extends StatefulWidget{

 PassEdit(keyed);
@override
  _PassEditState createState() => _PassEditState();
}

class _PassEditState extends State<PassEdit>{


  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Pass>('passim');
    Pass pass = box.get(keyed);
    return Scaffold(
        appBar: AppBar(
          title: Text('リスト追加'),
        ),
        body: Container(
            padding: EdgeInsets.all(64),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  const SizedBox(height: 8),
                  TextField(controller: TextEditingController
                    (text: pass.id),onChanged: (String value){
                    setState(() {
                     pass.id  = value;

                    });
                  },
                  ),

                ]
            ))

    );
  }

}







