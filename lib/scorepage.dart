import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:surveyapp/home_page.dart';

import 'model/dimension.dart';

class ScorePage extends StatefulWidget {
  final int? userId;
  final List<Dimension> dimensionList;
  // final List useranswerlist;
  // final List correctanswerlist;
  const ScorePage({Key? key, required this.userId, required this.dimensionList})
      : super(key: key);

  @override
  _ScorePageState createState() => _ScorePageState();
}

List<Map> roseData = [];
List<Map> raceData = [];

double getPercentage(int maxScore, int totalScore) {
  double factor = 100 / maxScore;
  return totalScore * factor;
}

String getLevel(int maxScore, int totalScore) {
  double distance = maxScore / 6;
  if (0 <= totalScore && totalScore <= distance) {
    return "A1";
  } else if (distance < totalScore && totalScore <= distance * 2) {
    return "A2";
  } else if (distance * 2 < totalScore && totalScore <= distance * 3) {
    return "B1";
  } else if (distance * 3 < totalScore && totalScore <= distance * 4) {
    return "B2";
  } else if (distance * 4 < totalScore && totalScore <= distance * 5) {
    return "C1";
  } else if (distance * 5 < totalScore && totalScore <= distance * 6) {
    return "C2";
  }
  return "";
}

class _ScorePageState extends State<ScorePage> {
  int count = 0;
  int total = 0;

  @override
  void initState() {
    roseData = [];
    // roseData.add({
    //   'value': getPercentage(36, 12).ceil(),
    //   'name': ' ( ${getLevel(36, 12)} ) 1. Bilgi ve veri okuryazarlığı',
    // });
    // roseData.add({
    //   'value': getPercentage(69, 46).ceil(),
    //   'name': ' ( ${getLevel(69, 46)} ) 2. İletişim ve işbirliği'
    // });
    // roseData.add({
    //   'value': getPercentage(48, 24).ceil(),
    //   'name': ' ( ${getLevel(48, 24)} ) 3. Dijital içerik oluşturma'
    // });
    // roseData.add({
    //   'value': getPercentage(24, 8).ceil(),
    //   'name': ' ( ${getLevel(24, 8)} ) 4. Güvenlik'
    // });
    // roseData.add({
    //   'value': getPercentage(12, 3).ceil(),
    //   'name': ' ( ${getLevel(12, 3)} ) 5. Sorun çözme'
    // });
    int count = 0;
    for (var item in widget.dimensionList) {
      count++;
      String level = getLevel(item.maxScore, item.totalScore);
      int percentage = getPercentage(item.maxScore, item.totalScore).ceil();
      roseData.add({
        'value': percentage,
        'name': '$count ($level)',
        // 'name': ' %$percentage ( $level ) ${item.dimensionName}',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle body = Theme.of(context).textTheme.bodyText1!;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leadingWidth: 200,
            leading: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                    (route) => false);
              },
              icon: const Icon(Icons.arrow_left_sharp),
              label: Text(AppLocalizations.of(context)!.exitButtonText),
              style: ElevatedButton.styleFrom(
                  elevation: 0, primary: Colors.blueGrey[800]),
            ),
            elevation: 2,
            backgroundColor: Colors.blueGrey[800],
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.scorePageTitle,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )),
        body: ListView(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  for (var i = 0; i < widget.dimensionList.length; i++)
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.15,
                              right: MediaQuery.of(context).size.width * 0.15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: Defaults.colors10[i]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(
                                  widget.dimensionList[i].dimensionName!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    margin: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Chart(
                      data: roseData,
                      variables: {
                        'name': Variable(
                          accessor: (Map map) => map['name'] as String,
                        ),
                        'value': Variable(
                          accessor: (Map map) => map['value'] as num,
                          scale: LinearScale(min: 0, max: 120),
                        ),
                      },
                      elements: [
                        IntervalElement(
                          label: LabelAttr(
                              encoder: (tuple) =>
                                  Label('% ' + tuple['value'].toString())),
                          elevation: ElevationAttr(value: 0, updaters: {
                            'tap': {true: (_) => 5}
                          }),
                          color: ColorAttr(
                              variable: 'name', values: Defaults.colors10),
                        )
                      ],
                      axes: [
                        Defaults.horizontalAxis,
                        Defaults.verticalAxis,
                      ],
                      selections: {
                        'tap': PointSelection(
                          on: {
                            GestureType.hover,
                            GestureType.tap,
                          },
                          dim: Dim.x,
                        )
                      },
                      tooltip: TooltipGuide(),
                      crosshair: CrosshairGuide(),
                    ),
                    // child: Chart(
                    //   data: roseData,
                    //   variables: {
                    //     'name': Variable(
                    //       accessor: (Map map) => map['name'] as String,
                    //     ),
                    //     'value': Variable(
                    //       accessor: (Map map) => map['value'] as num,
                    //     ),
                    //   },
                    //   elements: [
                    //     IntervalElement(
                    //       label: LabelAttr(
                    //           encoder: (tuple) =>
                    //               Label(' % ' + tuple['value'].toString())),
                    //       color: ColorAttr(
                    //           variable: 'name', values: Defaults.colors10),
                    //     )
                    //   ],
                    //   coord: RectCoord(transposed: true),
                    //   axes: [
                    //     Defaults.verticalAxis
                    //       ..line = Defaults.strokeStyle
                    //       ..grid = null,
                    //     Defaults.horizontalAxis
                    //       ..line = null
                    //       ..grid = Defaults.strokeStyle,
                    //   ],
                    //   selections: {'tap': PointSelection(dim: Dim.x)},
                    // ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Chart(
                      data: roseData,
                      variables: {
                        AppLocalizations.of(context)!.level: Variable(
                          accessor: (Map map) => map['name'] as String,
                        ),
                        AppLocalizations.of(context)!.value: Variable(
                          accessor: (Map map) => map['value'] as num,
                          scale: LinearScale(min: 0, max: 100),
                        ),
                      },
                      elements: [
                        IntervalElement(
                          label: LabelAttr(
                              encoder: (tuple) => Label(" % " +
                                  tuple[AppLocalizations.of(context)!.value]
                                      .toString())),
                          shape: ShapeAttr(
                              value: RectShape(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                          )),
                          color: ColorAttr(
                              variable: AppLocalizations.of(context)!.level,
                              values: Defaults.colors10),
                          elevation: ElevationAttr(value: 5),
                        )
                      ],
                      selections: {
                        'tap': PointSelection(
                          on: {
                            GestureType.hover,
                            GestureType.tap,
                          },
                          dim: Dim.x,
                        )
                      },
                      tooltip: TooltipGuide(),
                      coord: PolarCoord(startRadius: 0.15),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Chart(
                      data: roseData,
                      variables: {
                        'name': Variable(
                          accessor: (Map map) => map['name'] as String,
                        ),
                        'value': Variable(
                          accessor: (Map map) => map['value'] as num,
                          scale: LinearScale(min: 0, max: 100),
                        ),
                      },
                      elements: [
                        IntervalElement(
                          label: LabelAttr(
                              encoder: (tuple) =>
                                  Label(" % " + tuple['value'].toString())),
                          color: ColorAttr(
                            variable: 'name',
                            values: Defaults.colors10,
                          ),
                        )
                      ],
                      selections: {
                        'tap': PointSelection(
                          on: {
                            GestureType.hover,
                            GestureType.tap,
                          },
                          dim: Dim.x,
                        )
                      },
                      tooltip: TooltipGuide(),
                      coord: PolarCoord(transposed: true),
                      axes: [
                        Defaults.radialAxis..label = null,
                        Defaults.circularAxis,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.15,
                  //   width: MediaQuery.of(context).size.width * 0.5,
                  //   child: Center(
                  //     child: ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         padding: const EdgeInsets.all(20),
                  //         primary: Colors.blueGrey[800],
                  //       ),
                  //       onPressed: () {
                  //         Navigator.pushAndRemoveUntil(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => const HomePage(),
                  //             ),
                  //             (route) => false);
                  //       },
                  //       child: Text(
                  //         AppLocalizations.of(context)!.homePageButtonText,
                  //         style: TextStyle(
                  //             fontSize: 20,
                  //             color: Colors.white),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ));
  }
}
