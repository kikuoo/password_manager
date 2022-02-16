import 'package:flutter/material.dart';
import 'Pass.dart';
import 'package:flutter/cupertino.dart';


class PassList extends StatelessWidget{
  final List<Pass> pass;
  const PassList(this.pass);
  Widget build(BuildContext context){
    return ListView.builder(
        itemCount:pass.length,
        itemBuilder:(BuildContext context,int index){
          var pas = pass[index];
          return _buildPass(pas);
        }

    );


  }
}

_buildPass(Pass passed){
  return Card(
    color: Colors.white,
    margin: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment:CrossAxisAlignment.center,
    children: <Widget>[
    Text(passed.name,style: TextStyle(fontSize: 30)),
    Text(passed.id,style: TextStyle(fontSize: 30)),
    Text(passed.password,style: TextStyle(fontSize: 30)),
    Text(passed.remark,style: TextStyle(fontSize: 30)),
    ],

  ));


}