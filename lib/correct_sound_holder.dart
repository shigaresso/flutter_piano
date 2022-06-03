import 'dart:math';

/// 正解音を保持するクラス
class CorrectSoundHolder {
  late int _nowScale;
  late final int _scaleCount;

  /// 正解音を鳴らしたい時に必要
  int get nowScale => _nowScale;

  CorrectSoundHolder({required numberOfScale}) {
    _scaleCount = numberOfScale;
    _nowScale = createRandomInt();
  }

  /// 選択したボタンの音が正しいかどうかの判定
  bool judgeSelectSound(int sound) {
    if (_nowScale == sound) {
      _nowScale = createRandomInt();
      return true;
    } else {
      return false;
    }
  }

  /// Random 関数の実装を変更したい時に複数箇所で変更せず、ここだけの変更で良いように定義している
  int createRandomInt() {
    return Random().nextInt(_scaleCount);
  }
}
