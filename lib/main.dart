import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animation/circle_progress_bar.dart';
import 'package:flutter_animation/long_press_bloc.dart';
import 'capture_button.dart';
import 'package:flutter_animation/long_press_event_counter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = LongPressBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //List<Size> sizes = [Size(70,70),Size(50,50)];

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onLongPress: ()=> _bloc.counterEventSink.add(LongPressStartEvent()),
          onLongPressUp: ()=>_bloc.counterEventSink.add(LongPressEndEvent()),
          child: new Stack(
            alignment: Alignment.center,
            children: <Widget>[
              new StreamBuilder(
                  stream: _bloc.bigBtnSizeTween,
                  //initialData: SizeTween(begin:Size(70,70),end: Size(100, 100)),
                  builder: (context,snapshot){
                    return new CaptureButton(defaultSize:Size(70,70),color: Colors.grey,sizeTween: snapshot.data,);
                  }),
              new StreamBuilder(
                  stream: _bloc.smallBtnSizeTween,
                  //initialData: SizeTween(begin:Size(50,50),end: Size(40, 40)),
                  builder: (context,snapshot){
                    return new CaptureButton(defaultSize:Size(50,50),color: Colors.white,sizeTween: snapshot.data,);
                  }),
              new StreamBuilder(
                  stream: _bloc.showProgress,
                  initialData: false,
                  builder: (context,snapshot){
                    //todo: stop animation when data is false
                    if(snapshot.data){
                      return new CircleProgressBar(
                        foregroundColor: Colors.greenAccent,
                        value: 1.0,
                        duration: Duration(seconds: 10),
                        container:new Container(),
                      );
                    }
                    return new Container();

                  })
            ],
          ),
        ),
      )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  /*
  Container(
            child: Text('I am a text'),
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
          )

          CircleProgressBar(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.red,
                  value: 0.9,
                  duration: Duration(seconds: 10),
                  container:CaptureButton(size: Size(100, 100),color: Colors.yellow,) ,
                )
   */
}
