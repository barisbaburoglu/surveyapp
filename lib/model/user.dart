class User {
  int? id;
  String? userMail;
  int? userAge;
  int? userGender;
  String? tarih;

  User({this.id, this.userMail, this.userAge, this.userGender, this.tarih});

  User.fromJson(Map<String, dynamic> mapOfJson)
      : id = mapOfJson["id"],
        userMail = mapOfJson["userMail"],
        userAge = mapOfJson["userAge"],
        userGender = mapOfJson["userGender"],
        tarih = mapOfJson["tarih"];

  Map<String, dynamic> toJson() => {
        'userMail': userMail,
        'userAge': userAge,
        'userGender': userGender,
        'tarih': tarih
      };
}
