import 'package:flutter/material.dart';
import 'package:surveyapp/model/language.dart';
import 'package:surveyapp/second_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'api_edu40.dart';

class FirstPage extends StatefulWidget {
  String codeLang;
  FirstPage({Key? key, required this.codeLang}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final ApiEdu40 _apiEdu40 = ApiEdu40();

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.blueGrey[800],
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  var _futureLanguage;

  void getLanguages() async {
    _futureLanguage = ApiEdu40().getLanguages();
  }

  late bool _loadingLanguages;
  List<Language>? languages;
  void fetchLanguage() async {
    Language language = Language();
    languages = await ApiEdu40().getLanguages();

    setState(() {
      _loadingLanguages = false;
    });
  }

  @override
  void initState() {
    _loadingLanguages = true;
    super.initState();

    //getLanguages();
    fetchLanguage();
  }

  void showCustomOkDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                title,
                style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(content,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    AppLocalizations.of(context)!.okButtonText,
                    style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 200,
        leading: ElevatedButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_left_sharp),
          label: Text(AppLocalizations.of(context)!.exitButtonText),
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.blueGrey[800]),
        ),
        elevation: 2,
        backgroundColor: Colors.blueGrey[800],
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage("assets/logo.png"),
            ),
            const Text(
              'Education 4.0 for Youth',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
              ),
            ),
            widget.codeLang == "tr"
                ? const Text(
                    'Dijital Yeterlilik Haritası',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                : const Text(""),
            SizedBox(height: MediaQuery.of(context).size.height * 0.10),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: 300,
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                    title: AppLocalizations.of(context)!
                                        .appBarTitleStudent,
                                    anketId: 1,
                                    codeLang: widget.codeLang,
                                    maxScore: 3,
                                  )),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .studentSurveyButtonGoText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                    title: AppLocalizations.of(context)!
                                        .appBarTitleTeacher,
                                    anketId: 3,
                                    codeLang: widget.codeLang,
                                    maxScore: 4,
                                  )),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .teacherSurveyButtonGoText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SecondPage(
                                    title: AppLocalizations.of(context)!
                                        .appBarTitleEmployer,
                                    anketId: 2,
                                    codeLang: widget.codeLang,
                                    maxScore: 3,
                                  )),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!
                                .employerSurveyButtonGoText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
