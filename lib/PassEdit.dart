import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/PassList.dart';
import 'package:password_manager/main.dart';
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

    final nameController = TextEditingController(text: pass.name);
    final idController = TextEditingController(text: pass.id);
    final passwordController = TextEditingController(text: pass.password);
    final remarkController = TextEditingController(text: pass.remark);

    String _text1;
    String _text2;
    String _text3;
    String _text4;

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
                  TextFormField(controller: nameController
                    ,onChanged: (String value){
                    nameController.selection =
                    TextSelection.fromPosition(TextPosition(offset:nameController.text.length),
                    );
                  _text1 = value;
                  },
                  ),
                  TextFormField(controller: idController
                    ,onChanged: (String value){
                      idController.selection =
                          TextSelection.fromPosition(TextPosition(offset:idController.text.length),
                          );
                      _text2 = value;
                    },
                  ),
                  TextFormField(controller: passwordController
                    ,onChanged: (String value){
                      passwordController.selection =
                          TextSelection.fromPosition(TextPosition(offset:passwordController.text.length),
                          );
                      _text3 = value;
                    },
                  ),
                  TextFormField(controller: remarkController
                    ,onChanged: (String value){
                      remarkController.selection =
                          TextSelection.fromPosition(TextPosition(offset:remarkController.text.length),
                          );
                      _text4 = value;
                    },
                  ),

                    const SizedBox(height: 8),
                    Container(
                        width: double.infinity,

                         child: ElevatedButton(
                          onPressed: ()  {
                            setState(() {
                              pass.name = _text1;
                              pass.id = _text2;
                              pass.password =_text3;
                              pass.remark = _text4;
                            });
                            Navigator.push(context, MaterialPageRoute(
                                builder:(context) => PassListPage()
                            ));

                      },


                             child: Text('保存', style: TextStyle(color: Colors.white)),
                    ),)

                ]
            ))

    );
  }

}







