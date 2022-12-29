import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surveyapp/constant.dart';
import 'package:surveyapp/model/answer.dart';
import 'package:surveyapp/model/language.dart';
import 'package:surveyapp/model/question.dart';
import 'package:surveyapp/model/user.dart';

class ApiEdu40 {
  Future<List<Language>?> getLanguages() async {
    Uri url = Uri.parse("$api/languages");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var body = response.body;
      var statesJsonArray = json.decode(body);

      try {
        List<Language> results =
            (statesJsonArray as List).map((e) => Language.fromJson(e)).toList();

        return results;
      } catch (e) {
        log('try failed $e');
      }
    } else {
      log('api request failed ${response.body}');

      return null;
    }
  }

  Future<List<Question>?> getQuestions(int anketId, String codeLang) async {
    final response = await http.post(
      Uri.parse('$api/questions/GetQuestions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, dynamic>{'anketId': anketId, 'codeLang': codeLang}),
    );

    if (response.statusCode == 200) {
      var body = response.body;
      var statesJsonArray = json.decode(body)['results'];

      try {
        List<Question> results =
            (statesJsonArray as List).map((e) => Question.fromJson(e)).toList();

        return results;
      } catch (e) {
        log('try failed $e');
      }
    } else {
      log('api request failed ${response.body}');

      return null;
    }
  }

  Future<User> createUser(User user) async {
    final response = await http.post(
      Uri.parse('$api/questions/createuser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create user.');
    }
  }

  Future<Answer> createAnswer(Answer answer) async {
    final response = await http.post(
      Uri.parse('$api/questions/CreateAnswer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(answer.toJson()),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return Answer.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create survey.');
    }
  }
}
