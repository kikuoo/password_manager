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
  runApp(MyPassApp());

}


class MyPassApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Pass App',
      theme: ThemeData(
       // primarySwatch: Colors.blueGrey,
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
   bool _searchBoolean = false;
   List<Pass> passes = [] ;
   List<Pass> _passes2 = [];
   var _text = '';
   List<int> keys  = [];
   List<int> keys2 = [];
   Widget _searchTextField(){
     return TextFormField(
       onChanged: (String value){
         setState(() {
           _text = value;
         });
       },
       autofocus: true,
       cursorColor: Colors.white,
       style: TextStyle(
         color: Colors.white,
         fontSize: 20,
       ),
       textInputAction: TextInputAction.search,
       decoration:  InputDecoration(
      enabledBorder:  UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white)
      ),
         focusedBorder: UnderlineInputBorder(
           borderSide: BorderSide(color: Colors.white)
         ),
         hintText: 'Search',
         hintStyle: TextStyle(
           color: Colors.white60,
           fontSize: 20,
         )
     )
     );
   }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[500],
      appBar: AppBar(
        title:!_searchBoolean ? Text("Password manager") : _searchTextField(),
        actions: !_searchBoolean
        ?[IconButton(icon: Icon(Icons.search),
          onPressed: (){
          setState(() {
          _text = '';
            _searchBoolean = true;
          });
         })
      ]:[
        IconButton(
          icon: Icon(Icons.clear),
          onPressed:(){
            setState((){
              _searchBoolean = false;
            });
          }
        )
        ],
        backgroundColor:Colors.blueGrey[800],
      ),

      body:
        ValueListenableBuilder(
          valueListenable: Hive.box<Pass>('passim').listenable(),
          builder:(context,Box<Pass> box,widget){
              !_searchBoolean ?
              passes = box.values.toList() :
             passes = [];
              _passes2 = [];
             keys = [];
             keys2 = [];
              _passes2 = box.values.toList();
              for (int i = 0; i < _passes2.length; i++) {
                if (_passes2[i].name.contains(_text)) {
                  passes.add(_passes2[i]);
                  keys2.add(i);
                }
              }
              !_searchBoolean ? keys = box.keys.cast<int>().toList() :
              keys = keys2;
              return PassList(passes,keys);
        },
        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey[900],
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
        title: Text('???????????????'),
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
                child: Text('???????????????', style: TextStyle(color: Colors.white)),
              ),

            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('???????????????'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








