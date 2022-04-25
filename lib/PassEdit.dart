import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'Pass.dart';

//int keyed;
class PassEdit extends StatefulWidget{
  final int keyed;
  PassEdit({this.keyed});

 _PassEditState createState() => _PassEditState();
}

class _PassEditState extends State<PassEdit>{

  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Pass>('passim');
    Pass pass = box.get(widget.keyed);
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
                    (text: pass.name),onChanged: (String value){
                    setState(() {
                      pass.name = value;
                     // Navigator.defaultRouteName
                    });
                  },
                  ),
                    const SizedBox(height: 8),
                    Container(
                        width: double.infinity,

                         child: ElevatedButton(
                          onPressed: ()  {

                      },
                             child: Text('保存', style: TextStyle(color: Colors.white)),
                    ),)

                ]
            ))

    );
  }

}







