//import 'dart:html';
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
        itemCount:keys.length,
        itemBuilder:(context,int index){
          final int key = keys[index];
          var pas = pass[index] ;
          return _buildPass(pas,context,key);
        }
    );
  }
}

_buildPass(Pass passed,context,int key){
    return Card(elevation: 15,shadowColor: Colors.white60,
      margin: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      color: Colors.blueGrey[800],

        child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: Text("Edit"),
                    children: [
                      SimpleDialogOption(
                        onPressed: () {
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(width:500,alignment:Alignment.center,child:Text(passed.name, style: TextStyle(letterSpacing:10,
                fontSize: 30,color: Colors.white70))),
                _id(passed),
                _password(passed),
                _others(passed)
              ],
            )));
}


Widget _id(Pass passed){
  return Container(
    child: Row(
      children: [
        Container(decoration:BoxDecoration(color: Colors.white70
        , borderRadius: BorderRadius.circular(10)),width: 100,height: 30,margin:EdgeInsets.fromLTRB(10, 2, 10, 2),child: Text('ID',textAlign: TextAlign.center,style:TextStyle(fontSize: 25,color: Colors.blueGrey[800]) )),
        Container( width: 180,height: 30,margin:EdgeInsets.fromLTRB(10, 2, 10, 2),child:Text(passed.id,style: TextStyle(fontSize: 30,color: Colors.white70),)
        ),
      ],
    )
  );
}

Widget _password(Pass passed){
  return Container(
      child: Row(
        children: [
          Container(decoration:BoxDecoration(color: Colors.white70
              , borderRadius: BorderRadius.circular(10)),width: 100,height: 30,margin:EdgeInsets.fromLTRB(10, 2, 10, 2),child: Text('Password',textAlign: TextAlign.center,style:TextStyle(fontSize: 20,color: Colors.blueGrey[800]) )),
          Container( width: 180,height: 30,margin:EdgeInsets.fromLTRB(10, 2, 10, 2),child:Text(passed.password,style: TextStyle(fontSize: 30,color: Colors.white70),)
          ),
        ],
      )
  );
}

Widget _others(Pass passed){
  return Container(
      child: Row(
        children: [
          Container(decoration:BoxDecoration(color: Colors.white70

              , borderRadius: BorderRadius.circular(10)),width: 100,height: 30,margin:EdgeInsets.fromLTRB(10, 2, 10, 2),child: Text('Others',textAlign: TextAlign.center,style:TextStyle(fontSize: 25,color: Colors.blueGrey[800]) )),
          Container( width: 180,height: 30,margin:EdgeInsets.fromLTRB(10, 2, 10, 10),child:Text(passed.remark,style: TextStyle(fontSize: 30,color: Colors.white70),)
          ),
        ],
      )
  );
}



