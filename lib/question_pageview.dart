import 'package:flutter/material.dart';
import 'package:surveyapp/model/answer.dart';
import 'package:surveyapp/model/choice.dart';
import 'package:surveyapp/model/dimension.dart';
import 'package:surveyapp/options.dart';
import 'package:intl/intl.dart';
import 'package:surveyapp/scorepage.dart';
import 'api_edu40.dart';
import 'model/user.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef void OptionSelectedCallback(Choice option);

class QuestionsPageView extends StatefulWidget {
  final List results;
  final List wrongRightList;
  final int maxScore;
  final String codeLang;

  QuestionsPageView(
      {required this.results,
      required this.wrongRightList,
      required this.maxScore,
      required this.codeLang});

  @override
  _QuestionsPageViewState createState() => _QuestionsPageViewState();
}

class _QuestionsPageViewState extends State<QuestionsPageView> {
  Future<User>? _futureUser;
  Future<Answer>? _futureAnswer;
  List<Choice> _userAnswerList = [];
  List<String> correctanswerlist = [];
  int currentPagePosition = 0;
  PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _userAnswerList
        .addAll(widget.results.map((e) => Choice(id: "", score: "")));
    correctanswerlist = [];
    for (int i = 0; i < widget.results.length; i++) {
      correctanswerlist.add(widget.results.elementAt(i).correct_answer);
    }

    //show custom dialog when page start
    WidgetsBinding.instance!.addPostFrameCallback((_) => showCustomOkDialog(
        context,
        widget.results.elementAt(0).header,
        widget.results.elementAt(0).dimDescription,
        AppLocalizations.of(context)!.okButtonText));
  }

  void showCustomOkDialog(
      BuildContext context, String title, String content, String btnText) {
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
                          style: const TextStyle(fontSize: 16),
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
                    btnText,
                    style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle subtitle = Theme.of(context).textTheme.subtitle1!;
    final TextStyle body = Theme.of(context).textTheme.bodyText1!;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width > 765
                ? MediaQuery.of(context).size.width * 0.5
                : MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Center(
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _controller,
                itemCount: widget.results.length,
                pageSnapping: true,
                onPageChanged: (position) {
                  currentPagePosition = position;
                },
                itemBuilder: (context, index) {
                  Choice userAnswer = _userAnswerList[index];
                  int checkedOptionPosition =
                      widget.wrongRightList[index].indexOf(userAnswer);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 75,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey, width: 0.0),
                                          ),
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .number,
                                          labelStyle: const TextStyle(
                                              color: Color(0xfff9a825)),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xfff9a825),
                                                width: 0.0),
                                          )),
                                      controller: TextEditingController()
                                        ..text = '${index + 1}',
                                      onChanged: (text) {
                                        if (text.isEmpty) return;
                                        int qn = int.parse(text);
                                        if (qn > widget.results.length ||
                                            qn == 0) {
                                          return;
                                        }
                                        int page = qn;
                                        page = qn == 1 ? 2 : qn;
                                        if (_userAnswerList[page - 2]
                                                .id
                                                .isNotEmpty &&
                                            qn > 0 &&
                                            qn <= widget.results.length) {
                                          _controller.animateToPage(
                                              currentPagePosition ==
                                                      widget.results.length
                                                  ? currentPagePosition
                                                  : currentPagePosition =
                                                      qn - 1,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              curve: Curves.easeIn);
                                        } else {}
                                      },
                                    ),
                                  ),
                                  Text(
                                    ' /${widget.results.length}',
                                    style: TextStyle(color: Colors.yellow[800]),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(20),
                                    ),
                                    onPressed: () {
                                      _controller.animateToPage(
                                        currentPagePosition == 0
                                            ? 0
                                            : currentPagePosition - 1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeIn,
                                      );
                                    },
                                    child: Text(
                                      '< ' +
                                          AppLocalizations.of(context)!
                                              .previous,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    765
                                                ? 15
                                                : 12,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.all(15),
                                    ),
                                    onPressed: () {
                                      if (_userAnswerList[currentPagePosition]
                                          .id
                                          .isNotEmpty) {
                                        _controller.animateToPage(
                                            currentPagePosition ==
                                                    widget.results.length - 1
                                                ? currentPagePosition
                                                : currentPagePosition + 1,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.next + ' >',
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width >
                                                    765
                                                ? 15
                                                : 12,
                                      ),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.results.elementAt(index).question}',
                          style: TextStyle(
                              color: Colors.yellow[800], fontSize: 18),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.results.elementAt(index).description}',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Options(
                          index: index,
                          wrongRightList: widget.wrongRightList,
                          selectedPosition: checkedOptionPosition,
                          onOptionsSelected: (selectedOption) {
                            _userAnswerList[currentPagePosition] =
                                selectedOption;
                            _controller.animateToPage(
                                currentPagePosition == widget.results.length - 1
                                    ? currentPagePosition
                                    : currentPagePosition + 1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeIn);
                            if (index + 1 < widget.results.length &&
                                widget.results
                                        .elementAt(index + 1)
                                        .dimDescription !=
                                    "") {
                              showCustomOkDialog(
                                  context,
                                  widget.results.elementAt(index + 1).header,
                                  widget.results
                                      .elementAt(index + 1)
                                      .dimDescription,
                                  AppLocalizations.of(context)!.okButtonText);
                            }
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width > 765
                  ? MediaQuery.of(context).size.width * 0.5
                  : MediaQuery.of(context).size.width * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(10),
                        primary: Colors.blueGrey[800],
                        fixedSize:
                            Size(MediaQuery.of(context).size.width * 0.7, 50)),
                    onPressed: () {
                      if (widget.wrongRightList.length - 1 ==
                              currentPagePosition &&
                          _userAnswerList[widget.wrongRightList.length - 1]
                                  .id !=
                              "") {
                        DateTime now = DateTime.now();

                        setState(() {
                          var uuid = const Uuid();
                          _futureUser = ApiEdu40().createUser(User(
                              userMail: uuid.v1(),
                              userAge: 99,
                              userGender: 1,
                              tarih: DateFormat('yyyy.MM.dd').format(now)));
                        });
                        int totalScore = 0;
                        Dimension dimension =
                            Dimension(totalScore: 0, maxScore: 0);
                        List<Dimension> dimensionList = [];
                        int count = 0;
                        String? dim = "0";
                        _futureUser!.then((user) => {
                              for (var answer in _userAnswerList)
                                {
                                  _futureAnswer = ApiEdu40().createAnswer(
                                      Answer(
                                          choicesId: int.parse(answer.id),
                                          userId: user.id,
                                          codeLang: widget.codeLang))
                                },
                              for (var answer in _userAnswerList)
                                {
                                  if (answer.dimenson != "99" &&
                                      dim != answer.dimenson)
                                    {
                                      count = 0,
                                      totalScore = 0,
                                      dim = answer.dimenson,
                                      for (var answer2 in _userAnswerList)
                                        {
                                          if (answer.dimenson ==
                                              answer2.dimenson)
                                            {
                                              count++,
                                              totalScore = totalScore +
                                                  int.parse(answer2.score),
                                              dimension = Dimension(
                                                  dimensionName:
                                                      answer2.dimensonName,
                                                  totalScore: totalScore,
                                                  maxScore: 0)
                                            }
                                        },
                                      dimension.maxScore =
                                          count * widget.maxScore,
                                      dimensionList.add(dimension),
                                    },
                                },
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScorePage(
                                      userId: user.id,
                                      dimensionList: dimensionList,
                                    ),
                                  ),
                                  (route) => false)
                            });
                      } else {
                        showCustomOkDialog(
                            context,
                            "!",
                            AppLocalizations.of(context)!.errorSendMessage,
                            AppLocalizations.of(context)!.okButtonText);
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context)!.sendSurveyButtonText,
                      style: const TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
