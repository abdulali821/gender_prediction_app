import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var result;
  predictGender (String name)async{
    var url = "http://api.genderize.io/?name=$name";
    var res = await http.get(url);
    var body = jsonDecode(res.body);
    result = "GENDER:  ${body['gender']}\nPROBABILITY: ${body['probability']}";
    setState(() {});
  }
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Gender Predictor")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                      "Enter a Name to Predict it's Gender."
                  ,style: TextStyle(
                  fontSize: 22,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Name"
                    ),
                  ),
                ),
              RaisedButton(
                  onPressed:() => predictGender(_nameController.text),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Predict"
                  ),
                ),
              ),
              if(result!=null) Text(result)
            ],
          ),
      ),
    );
  }
}

