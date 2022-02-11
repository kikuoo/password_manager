import 'package:flutter/material.dart';
import 'Pass.dart';

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
    child:Padding(padding: const EdgeInsets.all(20.0),
    child: Text(passed.name,style: TextStyle(fontSize: 30)),


  ));


}