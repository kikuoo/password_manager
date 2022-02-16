import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'Pass.dart';
import 'PassList.dart';


void main() async{
  await Hive.initFlutter();
 await Hive.openBox<Pass>('passim');
  Hive.registerAdapter(PassAdapter());
  runApp(MyPassApp());
}

class MyPassApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Pass App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PassListPage(),
    );
  }
}


class PassListPage extends StatefulWidget {
  @override
  _PassListPageState createState() => _PassListPageState();
}


class _PassListPageState extends State<PassListPage> {
 // List<PassCard> passList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),


      ),
      body:
        ValueListenableBuilder(
          valueListenable: Hive.box<Pass>('passim').listenable(),
          builder:(context,box,widget){
            var passes = box.values.toList();
            return PassList(passes);
        },
        ),



      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return PassAddPage();
            }),
          );
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PassAddPage extends StatefulWidget {
  @override
  _PassAddPageState createState() => _PassAddPageState();
}

class _PassAddPageState extends State<PassAddPage> {

  String _text1 = '';
  String _text2 = '';
  String _text3 = '';
  String _text4 = '';


  @override
  Widget build(BuildContext context) {
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
            TextField( decoration: InputDecoration(
                labelText: "Title",
                ),
              onChanged: (String value) {
                setState(() {
                  _text1 = value;
                });
              },
            ),

            TextField(
              decoration: InputDecoration(
                labelText: "ID",
              ),
              onChanged: (String value) {
                setState(() {
                  _text2 = value;
                });
              },
            ),

            TextField(
              decoration: InputDecoration(
                labelText: "Password",
              ),
              onChanged: (String value) {
                setState(() {
                  _text3 = value;
                });
              },
            ),

          TextField(
            decoration: InputDecoration(
              labelText: "Remarks",

            ),
            onChanged: (String value) {
              setState(() {
                _text4 = value;
              });
            },
          ),

            const SizedBox(height: 8),
            Container(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: ()  {
                  var passData =  Hive.box<Pass>('passim');
                  var pass = Pass(this._text1,this._text2,this._text3,this._text4);
                  passData.add(pass);

                  Navigator.of(context).pop();
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),

            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class PassCard extends StatelessWidget {

  final String _name;
  final String _id;
  final String _password;
  final String _remarks;

  PassCard(this._name, this._id, this._password,this._remarks);

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(width: 400,
                  decoration: BoxDecoration(
                    // 枠線
                    border: Border.all(color: Colors.blue, width: 2),
                    // 角丸
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.only(top: 5, right: 20, bottom: 10, left: 30),
                child: Text('Title: '+_name,style:TextStyle(fontSize: 20))
                ),
              Container(width: 400,
                  padding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 30),
                child: Text(' ID :' + _id,style:TextStyle(fontSize: 20))
                ),
              Container(width: 400,
                  padding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 30),
                child: Text('Pw :' + _password,style:TextStyle(fontSize: 20))
                ),
              Container(width: 400,
                padding: EdgeInsets.only(top: 5, right: 20, bottom: 5, left: 30),
                child: Text( 'Re :' +  _remarks,style:TextStyle(fontSize: 20))
              )
            ],
    );
  }
}
