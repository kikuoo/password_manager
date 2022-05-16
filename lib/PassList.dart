import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'main.dart';
import 'PassEdit.dart';
import 'Pass.dart';

class PassList extends StatelessWidget{
  final List<Pass> pass;
  final List<int> keys;

  const PassList(this.pass,this.keys);
  Widget build(BuildContext context){
    return ListView.builder(
        itemCount:pass.length,
        itemBuilder:(context,int index){
          final int key = keys[index];
          var pas = pass[index];
          return _buildPass(pas,context,key);
        }
    );
  }
}

_buildPass(Pass passed,context,int key){
    return Card(
        child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("This is the title"),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
                          //var box = Hive.box<Pass>('passim');
                         Navigator.push(context,MaterialPageRoute(builder:(context)
                            => PassEdit(keyed: key)
                          ));
                        },
                        child: Text("edit"),
                      ),
                      SimpleDialogOption(
                        onPressed: (){
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return AlertDialog(
                                title: Text("Deletion confirmation"
                                    ""),
                                content: Text("Can I delete it ?"),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(builder:(context)
                                      => PassListPage()
                                      ));
                                    }
                                  ),
                                  TextButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        var box = Hive.box<Pass>('passim');
                                        box.delete(key);
                                        Navigator.push(context,MaterialPageRoute(builder:(context)
                                        => PassListPage()
                                        ));
                                      }
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("delete"),
                      ),
                      SimpleDialogOption(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel"),
                      ),
                    ],
                  );
                },
              );
              },
            //color:Colors.white,
            //margin: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(passed.name, style: TextStyle(fontSize: 30)),
                Text(passed.id, style: TextStyle(fontSize: 30)),
                Text(passed.password, style: TextStyle(fontSize: 30)),
                Text(passed.remark, style: TextStyle(fontSize: 30)),
              ],
            )));
}



