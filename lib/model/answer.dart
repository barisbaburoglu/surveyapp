class Answer {
  int? choicesId;
  int? userId;
  String? codeLang;

  Answer({this.choicesId, this.userId, this.codeLang});

  Answer.fromJson(Map<String, dynamic> mapOfJson)
      : choicesId = mapOfJson["choicesId"],
        userId = mapOfJson["userId"],
        codeLang = mapOfJson["codeLang"];

  Map<String, dynamic> toJson() =>
      {'choicesId': choicesId, 'userId': userId, 'codeLang': codeLang};
}
