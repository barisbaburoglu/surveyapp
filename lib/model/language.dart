class Language {
  int? id;
  String? languageName;
  String? codeLang;

  Language({this.id, this.languageName, this.codeLang});

  factory Language.fromJson(Map<String, dynamic> mapOfJson) {
    return Language(
        id: mapOfJson['id'],
        languageName: mapOfJson['languageName'],
        codeLang: mapOfJson['codeLang']);
  }
}
