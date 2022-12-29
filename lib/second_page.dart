import 'package:flutter/material.dart';
import 'package:surveyapp/api_edu40.dart';

import 'package:surveyapp/question_pageview.dart';
import 'package:surveyapp/model/shuffleanswers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//todo change this name
typedef void Randomise(List options);

class SecondPage extends StatefulWidget {
  List wrongRightList = [];
  int anketId;
  String codeLang;
  String title;
  int maxScore;

  SecondPage(
      {Key? key,
      required this.anketId,
      required this.codeLang,
      required this.title,
      required this.maxScore})
      : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final ApiEdu40 _apiEdu40 = ApiEdu40();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 200,
          leading: ElevatedButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_left_sharp),
            label: Text(
              AppLocalizations.of(context)!.homePageButtonText,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width > 765 ? 15 : 11,
              ),
            ),
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
                child: Text(widget.title,
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:
                          MediaQuery.of(context).size.width > 765 ? 15 : 11,
                    )),
              ),
            ],
          )),
      body: _futureWidget(),
    );
  }

  _futureWidget() {
    return FutureBuilder(
      future: _apiEdu40.getQuestions(widget.anketId, widget.codeLang),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List results = snapshot.data as List;
          ShuffleRight(
              result: results,
              Shuffler: (options) {
                widget.wrongRightList = options;
              });

          return QuestionsPageView(
            codeLang: widget.codeLang,
            results: results,
            wrongRightList: widget.wrongRightList,
            maxScore: widget.maxScore,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
