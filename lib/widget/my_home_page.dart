import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_piano/correct_sound_holder.dart';
import 'package:flutter_piano/widget/empty_appbar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AudioCache _player = AudioCache();
  final CorrectSoundHolder _correctSoundHolder =
      CorrectSoundHolder(numberOfScale: numberOfScales.length);
  static final numberOfScales = ['C', 'D', 'E', 'F', 'G', 'A', 'B'];

  int nowCorrectAnswer = 0;
  int maxCorrectAnswer = 0;

  void incrementCounter(int sound, var scale) async {
    final isJudge = _correctSoundHolder.judgeSelectSound(sound);
    // 大文字を小文字化 これは、ファイル名に大文字を使ってはいけないが表示には大文字を用いたいので
    _player.play('sounds/${scale.toLowerCase()}.wav');
    setState(() {
      nowCorrectAnswer = _correctSoundHolder.now;
      maxCorrectAnswer = _correctSoundHolder.max;
    });
    if (isJudge) {
      await Future.delayed(
        const Duration(milliseconds: 400),
      );
      _player.play(
          'sounds/${numberOfScales[_correctSoundHolder.nowScale].toLowerCase()}.wav');
    } else {
      _player.play('sounds/wrong_answer.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '連続正解数：$nowCorrectAnswer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '最大正解数：$maxCorrectAnswer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            SizedBox(
              width: 400,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  _player.play(
                      'sounds/${numberOfScales[_correctSoundHolder.nowScale].toLowerCase()}.wav');
                  print('答えは:${_correctSoundHolder.nowScale} もう一度鳴らす');
                },
                child: const Text('もう一度鳴らす'),
              ),
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < numberOfScales.length; i++)
                  SoundWidget(
                      text: numberOfScales[i],
                      number: i,
                      onTap: incrementCounter),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class SoundWidget extends StatelessWidget {
  final String text;
  final int number;
  final Function _opTap;

  SoundWidget({
    Key? key,
    required this.text,
    required this.number,
    required Function onTap,
  })  : _opTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 90,
      child: ElevatedButton(
        onPressed: () {
          print(text);
          _opTap(number, text);
        },
        child: Text(text),
      ),
    );
  }
}
