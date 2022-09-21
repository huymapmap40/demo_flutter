import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'components/custom_card.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> _listInputed = [];
  TextEditingController inputTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("Init firebase success.");
      setState(() {});
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _closeDrawer() {
    Navigator.maybePop(context);
  }

  void _addStringToList(String textInput) {
    setState(() {
      _listInputed.add(textInput);
    });
  }

  void _readFirestoreData() async {
    CollectionReference manufacturer =
        FirebaseFirestore.instance.collection('manufacturer');
    DocumentReference acshBrand = manufacturer.doc('ac_schnitzer');
    var snapshot =
        await acshBrand.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print("Document data:");
        return documentSnapshot.data();
      } else {
        print("Not exist document data.");
        return null;
      }
    });
    int ab = 10;
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            sizedBoxSpace,
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    maxLines: 1,
                    controller: inputTextController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Input some text',
                      suffixText: 'NAME',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addStringToList(inputTextController.text);
                    inputTextController.clear();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
            sizedBoxSpace,
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _listInputed = [];
                });
              },
              child: Text('Clear all items'),
            ),
            sizedBoxSpace,
            Expanded(
              child: ListView.builder(
                itemCount: _listInputed.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Text(_listInputed[index]);
                },
              ),
            ),
            CustomCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _readFirestoreData,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      drawer: Drawer(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Test drawer abcxyz'),
            CloseButton(
              onPressed: _closeDrawer,
              color: Colors.amber,
            )
          ],
        ),
      )),
    );
  }
}
