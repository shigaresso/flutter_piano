import 'dart:math';

/// 正解音を保持するクラス
class CorrectSoundHolder {
  late int _nowScale;
  late final int _scaleCount;
  late int _now = 0;
  late int _max = 0;

  /// 正解音を鳴らしたい時に必要
  int get nowScale => _nowScale;
  int get now => _now;
  int get max => _max;

  CorrectSoundHolder({required numberOfScale}) {
    _scaleCount = numberOfScale;
    _nowScale = createRandomInt();
    _now = 0;
    _max = 0;
  }

  /// 選択したボタンの音が正しいかどうかの判定
  bool judgeSelectSound(int sound) {
    if (_nowScale == sound) {
      _now += 1;
      if (_now > _max) _max = _now;
      _nowScale = createRandomInt();
      return true;
    } else {
      _now = 0;
      return false;
    }
  }

  /// Random 関数の実装を変更したい時に複数箇所で変更せず、ここだけの変更で良いように定義している
  int createRandomInt() {
    return Random().nextInt(_scaleCount);
  }
}
