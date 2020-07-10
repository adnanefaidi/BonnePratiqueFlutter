import 'package:flutter/material.dart';
import './quiz.dart';
import './gallery.dart';
import './camera.dart';
import './weather-form.dart';
import './qrscan.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurpleAccent])
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/logo.jpg'),
                ),
              ),
            ),
            ListTile(
              title: Text("Quiz", style: TextStyle(fontSize: 22),),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Quiz()));
              },
            ),
            Divider(
              color: Colors.deepPurple,
              thickness: 2,
            ),
            ListTile(
              title: Text("Weather", style: TextStyle(fontSize: 22)),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherForm()));
              },
            ),
            Divider(
              color: Colors.deepPurple,
              thickness: 2,
            ),
            ListTile(
              title: Text("Gallery", style: TextStyle(fontSize: 22)),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Gallery()));
              },
            ),
            Divider(
              color: Colors.deepPurple,
              thickness: 2,
            ),
            ListTile(
              title: Text("Camera", style: TextStyle(fontSize: 22)),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraPage()));
              },
            ),
            Divider(
              color: Colors.deepPurple,
              thickness: 2,
            ),
            ListTile(
              title: Text("QR Scan", style: TextStyle(fontSize: 22)),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>QRCodePage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("My First App"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text("Hello, world!", style: TextStyle(fontSize: 30, decorationThickness: 5),),
      ),
    );
  }

}