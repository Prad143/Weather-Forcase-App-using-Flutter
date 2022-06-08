import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

String cityname = '';
double weather_temp = 0;
double weather_feelslike = 0;
double weather_pressure = 0;
double weather_humidity = 0;
double weather_visiblity = 0;
String weather_description = "";

class _HomepageState extends State<Homepage> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 116, 227, 227),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 35, 49, 60),
        title: Center(
          child: Text(
            "Weather forecast",
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: MediaQuery.of(context).size.height - 60,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(
                    "https://images.unsplash.com/photo-1499346030926-9a72daac6c63?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8NHx8fGVufDB8fHx8&w=1000&q=80",
                  ),
                  fit: BoxFit.cover,
                )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              hintText: "City name",
                              labelText: "Enter the name of the city",
                              border: OutlineInputBorder()),
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 255, 255, 255)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      side: BorderSide(color: Colors.black)))),
                          onPressed: () {
                            apicall();
                            cityname = _textController.text;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SecondRoute()),
                            );
                          },
                          child: Text(
                            "CHECK WEATHER",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 20.0),
                          )),
                    ],
                  ),
                ) // Foreground widget here
                )
          ],
        ),
      ),
    );
  }

  Future<String> apicall() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=1d7c6a3ac0fb702225afd7a0ce66424f");
    final response = await http.get(url);
    return jsonDecode(response.body);
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 116, 227, 227),
        appBar: AppBar(
          title: Center(
            child: Text(
              "Weather Report",
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 35, 49, 60),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 56,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      "https://images.pexels.com/photos/2114014/pexels-photo-2114014.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    ),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                            height: 550,
                            width: 450,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0),
                                  bottomLeft: Radius.circular(40.0)),
                              color: Color.fromARGB(255, 39, 43, 47),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text("${cityname.toUpperCase()}",
                                    style: TextStyle(
                                        fontSize: 60.0, color: Colors.white)),
                              ),
                              FutureBuilder(
                                  future: apicall(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "${double.parse((weather_temp - 273).toStringAsFixed(2))} C\n\n",
                                        style: TextStyle(
                                            fontSize: 45.0,
                                            color: Colors.white),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                              FutureBuilder(
                                  future: apicall(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(
                                        "Weather Description  :  ${weather_description}\n\nFeels like  :  ${double.parse((weather_feelslike - 273).toStringAsFixed(2))} C\n\nHumidity  :  ${weather_humidity} g/m3\n\nPressure  :  ${weather_pressure} Hg\n\nVisibility  :  ${weather_visiblity} m\n\n",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  })
                            ])),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Future<String> apicall() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=${cityname}&appid=1d7c6a3ac0fb702225afd7a0ce66424f");
    final response = await http.get(url);
    weather_temp = jsonDecode(response.body)["main"]["temp"];
    weather_feelslike = jsonDecode(response.body)["main"]["feels_like"];
    weather_humidity = jsonDecode(response.body)["main"]["pressure"];
    weather_pressure = jsonDecode(response.body)["main"]["humidity"];
    weather_visiblity = jsonDecode(response.body)["visibility"];
    weather_description =
        jsonDecode(response.body)["weather"][0]["description"];
    return ("");
  }
}
