import 'package:flutter/cupertino.dart';

import 'Pass.dart';

class PassList extends StatelessWidget{
  final List<Pass> pass;
  const PassList(this.pass);
  Widget build(BuildContext context){
    return ListView.builder(
        itemCount.pass.length,
        itemBuilder(BuildContext context,int index){
          var pas = pass[index];
          return _buildPass(pas);


    }
        )
  }

}