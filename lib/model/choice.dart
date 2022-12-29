class Choice {
  String id;
  String? choice;
  String score;
  String? dimenson;
  String? dimensonName;

  Choice(
      {required this.id,
      this.choice,
      required this.score,
      this.dimenson,
      this.dimensonName});

  Choice.fromJson(Map<String, dynamic> mapOfJson)
      : id = mapOfJson["id"],
        choice = mapOfJson["choice"],
        score = mapOfJson["score"],
        dimenson = mapOfJson["dimenson"],
        dimensonName = mapOfJson["dimensonName"];
}
