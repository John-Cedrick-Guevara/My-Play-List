import 'package:flutter/material.dart';
import 'tasks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( // container of contents and bg
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding( // padding for contents
          padding: const EdgeInsets.all(40.0),
          child: Column( // main contents
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TO DO APP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  letterSpacing: 8,
                  color: Color(0xFFA400A0),
                ),
              ),

              Padding( // title
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "MY PLAY\nLIST",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'PressStart2P',
                    fontSize: 50,
                    height: 1.2,
                    color: Color(0xFFF070A0),
                  ),
                ),
              ),
              SizedBox( //  image container
                height: 350,
                child: Image.asset(
                  "assets/images/arcade.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Padding( // app description
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Welcome to My Play List, here you can explore or list down your to do list day by day. Life is easier when you know what to do.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "PressStart2P",
                    fontSize: 8,
                    color: Color(0xFFA400A0),
                  ),
                ),
              ),
              GestureDetector( // next button
                onTap:
                    () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyWidget()),
                      ),
                    },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(
                      image: AssetImage("assets/images/buttonBg.png"),
                      height: 55,
                    ),
                    Text(
                      "START THE PRODUCTIVITY",
                      style: TextStyle(
                        fontFamily: "PressStart2P",
                        color: Colors.white,
                        fontSize: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
