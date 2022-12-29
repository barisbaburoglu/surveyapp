import 'package:surveyapp/model/choice.dart';

class Question {
  String? question;
  String? header;
  String? dimDescription;
  String? description;
  String? correct_answer;
  List<Choice> incorrect_answers;

  Question(
      {this.question,
      this.header,
      this.correct_answer,
      required this.incorrect_answers,
      required this.dimDescription,
      required this.description});

  factory Question.fromJson(Map<String, dynamic> mapOfJson) {
    var list = mapOfJson['incorrect_answers'] as List;
    List<Choice> choiceList = list.map((i) => Choice.fromJson(i)).toList();
    return Question(
        question: mapOfJson['question'],
        header: mapOfJson['header'],
        dimDescription: mapOfJson['dimDescription'],
        description: mapOfJson['description'],
        correct_answer: mapOfJson['correct_answer'],
        incorrect_answers: choiceList);
  }
}
