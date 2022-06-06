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
  late final AudioCache _player;
  late final CorrectSoundHolder _correctSoundHolder;
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
    if (!isJudge) {
      _player.play('sounds/wrong_answer.mp3');
      return;
    }
    await Future.delayed(const Duration(milliseconds: 400));
    _player.play(
        'sounds/${numberOfScales[_correctSoundHolder.nowScale].toLowerCase()}.wav');
  }

  @override
  void initState() {
    super.initState();
    _player = AudioCache();
    _player.loadAll([
      'c.wav',
      'd.wav',
      'e.wav',
      'f.wav',
      'g.wav',
      'a.wav',
      'b.wav',
      'wrong_answer.mp3'
    ]);

    // 起動した時に、最初に当てる音を鳴らしたいのでここでイニシャライズ
    _correctSoundHolder =
        CorrectSoundHolder(numberOfScale: numberOfScales.length);
    _player.play(
        'sounds/${numberOfScales[_correctSoundHolder.nowScale].toLowerCase()}.wav');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: size.width / 16,
    );

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
                  style: kTextStyle,
                ),
                Text(
                  '最大正解数：$maxCorrectAnswer',
                  style: kTextStyle,
                ),
              ],
            ),
            Container(height: 20),
            SizedBox(
              width: size.width / 2,
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
            Container(height: 20),
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
            const SizedBox(height: 10),
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

  const SoundWidget({
    Key? key,
    required this.text,
    required this.number,
    required Function onTap,
  })  : _opTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 70,
        maxHeight: 900,
        minWidth: 5,
        maxWidth: 50,
      ),
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
