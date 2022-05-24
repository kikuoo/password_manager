import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'Pass.dart';
import 'PassList.dart';



Future<void> main() async{

  await Hive.initFlutter();
  Hive.registerAdapter<Pass>(PassAdapter());
   await Hive.openBox<Pass>('passim');
  //if (!Hive.isAdapterRegistered(0)) {
    //Hive.registerAdapter<Pass>(PassAdapter());
  //}
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('リスト一覧'),
      ),drawer: Drawer(




    ),
      body:
        ValueListenableBuilder(
          valueListenable: Hive.box<Pass>('passim').listenable(),
          builder:(context,Box<Pass> box,widget){
            var passes = box.values.toList();
            List<int> keys = box.keys.cast<int>().toList();

            return PassList(passes,keys);
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
                  _text1 = value ;
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




