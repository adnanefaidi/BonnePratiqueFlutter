import 'package:flutter/material.dart';
import './weather.dart';

class WeatherForm extends StatefulWidget {
  @override
  _WeatherFormState createState() => _WeatherFormState();
}

class _WeatherFormState extends State<WeatherForm> {
  String city;
  TextEditingController cityEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text((city==null)?'Weather':'${city}'), backgroundColor: Colors.blue),
      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                decoration: InputDecoration(hintText: 'Type a city ...'),
                controller: cityEditingController,
                onChanged: (String str) {
                  setState(() {
                    city = str;
                  });
                },
                onSubmitted: (String str) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Weather(city)));
                  cityEditingController.text = "";
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            child: RaisedButton(
              child: Text('Get Weather'),
              textColor: Colors.white,
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Weather(city)));
                cityEditingController.text = "";
              },
              color: Colors.blueAccent,
            ),
          )
        ],
      ),
    );
  }
}
