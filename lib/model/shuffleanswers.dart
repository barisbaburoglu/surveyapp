import 'package:surveyapp/second_page.dart';

class ShuffleRight {
  final List result;
  final Randomise Shuffler;
  final List wrongRightList = [];

  ShuffleRight({required this.result, required this.Shuffler}) {
    wrongRightList.addAll(result.map((e) => []));
    for (int i = 0; i < result.length; i++) {
      List wrong = result.elementAt(i).incorrect_answers;
      wrongRightList[i] = wrong;
    }
    Shuffler(wrongRightList);
  }
}
