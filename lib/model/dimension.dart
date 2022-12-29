class Dimension {
  String? dimensionName;
  int totalScore;
  int maxScore;
  String? level;

  Dimension(
      {this.dimensionName, required this.totalScore, required this.maxScore});

  // Dimension.fromJson(Map<String, dynamic> mapOfJson)
  //     : dimensionName = mapOfJson["dimensionName"],
  //       totalScore = mapOfJson["totalScore"];

  // Map<String, dynamic> toJson() => {
  //       'dimensionName': dimensionName,
  //       'totalScore': totalScore,
  //     };
}
