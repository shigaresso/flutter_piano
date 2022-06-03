import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_piano/correct_sound_holder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final CorrectSoundHolder _correctSoundHolder =
      CorrectSoundHolder(numberOfScale: 7);

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _newScale() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                print('もう一度鳴らす');
                print(_correctSoundHolder.nowScale);
              },
              child: Text('もう一度鳴らす'),
            ),
            ElevatedButton(
              onPressed: () {
                print('C');
                print(_correctSoundHolder.judgeSelectSound(0));
              },
              child: Text('C'),
            ),
            ElevatedButton(
              onPressed: () {
                print('D');
                print(_correctSoundHolder.judgeSelectSound(1));
              },
              child: Text('D'),
            ),
            ElevatedButton(
              onPressed: () {
                print('E');
                print(_correctSoundHolder.judgeSelectSound(2));
              },
              child: Text('E'),
            ),
            ElevatedButton(
              onPressed: () {
                print('F');
                print(_correctSoundHolder.judgeSelectSound(3));
              },
              child: Text('F'),
            ),
            ElevatedButton(
              onPressed: () {
                print('G');
                print(_correctSoundHolder.judgeSelectSound(4));
              },
              child: Text('G'),
            ),
            ElevatedButton(
              onPressed: () {
                print('A');
                print(_correctSoundHolder.judgeSelectSound(5));
              },
              child: Text('A'),
            ),
            ElevatedButton(
              onPressed: () {
                print('B');
                print(_correctSoundHolder.judgeSelectSound(6));
              },
              child: Text('B'),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
