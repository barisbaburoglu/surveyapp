import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:surveyapp/constant.dart';
import 'package:surveyapp/first_page.dart';
import 'package:surveyapp/main.dart';
import 'package:surveyapp/model/language.dart';
import 'package:url_launcher/url_launcher.dart';

import 'api_edu40.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isButtonDisabled = false;
  bool value = false;
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

    fetchLanguage();
  }

  String codeLang = defaultLanguageCode;

  void showPrivacyDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Privacy and Cookie Policy",
                style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text("Welcome",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'When you visit https://edu40.net/survey.html (hereinafter "Website", "Site") personal data is collected about you. This Privacy and Cookie Policy is meant to help you understand what personal data we collect, why we collect it, and how we delete it.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text("Data controller",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'Kahramanmaraş Teknokent (hereinafter "us", "our", "us") is responsible for the processing of your personal data and ensuring that it complies with the rules of the General Data Protection Regulation (GDPR).',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'Avşar Mahallesi, Batı Çevre Yolu Bulvarı, D:No: 259, ',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('46040',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Onikişubat/Kahramanmaraş',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('https://teknokentmaras.com/',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('bilgi@teknokentmaras.com',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('+90 (344) 300 1897',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Personal data',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'Personal data is information that can identify you, personally. For example: your name, email, address, telephone number, etc. When you use our Service, we collect and process the personal data, you provide to us. This occurs for instance if you answer a questionnaire; sign up for a newsletter; register as an administrator, or use a contact form. To the extent that you enter information such as name, address, workplace, gender, age, phone number and email, we process this personal data. You can enter this type of information while using the Service or contact forms.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Security',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'We have taken technical and organizational measures to prevent your data from being accidentally or illegally deleted, published, lost, impaired, disclosed without authorization, abused or otherwise processed in violation of the law.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Purpose',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          "When personal data such as gender, age, zip code or other background data is collected in the questionnaire, the purpose is most often to collect statistical information for analysis, reporting, and benchmarking of data. Publishing such analyses require that the user data is completely anonymous and does not contain any personal identification of a user. If you are asked to submit your email during the questionnaire, it is to identify your result. We can grant access to your result via email or delete your data on your request. This is your assurance that your personal results cannot be accessed by others. The legal basis on which we process your personal data, is in order to deliver the Service to you. Your email will only be used for other purposes, if the purpose is clearly stated when asked to submit your email. Examples include, but are not limited to, subscribing to a newsletter, asking for feedback on our Service, or receiving an email as part of an exercise/test. In case your organization has asked you to complete the questionnaire, personal information such as email and name also have the purpose of making your result identifiable. This ensures that the person(s) who asked you to fill out the questionnaire can find your result. Contact your organization's administrator for more information. Information such as name, phone, organization, email entered in a contact form is intended to qualify an answer to your inquiry. The legal basis on which we process your personal data is our legitimate interest.",
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Period of storage',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'We only store your data for the purposes described in this Privacy and Cookie Policy and for the time allowed by law. When we no longer need to use your personal data for the identified purposes and there is no need for us to keep it to comply with our legal or regulatory obligations, we will either remove it from our systems or anonymize it so that you cannot be identified.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Disclosure of information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'Besides otherwise described in this Privacy and Cookie Policy, we may disclose personal data that we collect or that you provide to trusted third-party providers (data processors). We only use data processors that can give your personal data adequate level of data protection. We only use data processors within the EU or in countries which can provide the adequate protection of your information.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Cookies',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'Our Website uses cookies. A cookie is a small text file that is stored in your browser. Cookies allow the Website to recognize your computer, gather information about which pages and features are visited with your browser and make sure the Website is technically functional. Cookies are the only way to make the site function as intended. Cookies are used by virtually all websites. The cookies that we issue are used to personalize the presentation of the Website based on your computer hardware (e.g. language, screen size), and allow you access to restricted and personal areas, such as your individual result.',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Cookies we use:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'When answering the questionnaire, the Website stores cookies that help the server register and link your answers, as well as the questions you have already answered. The Site uses cookies from Google Analytics to measure traffic on the Site. The Site can contain videos embedded on the page via YouTube, Vimeo or other video services, that use cookies to detect which video is displayed and how much of the video you have seen. Administrators logging on to the Site are authenticated via a cookie: token. The Website identifies the appropriate survey, template, language and setup via four cookies: survey_id, template_id, lang_id and setup_id. The Website stores your accept of cookies via a cookie: cookieAccept',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Insights and complaints',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'You are entitled to know what personal information we are processing about you. You may also object to the use of information at any time. You may also revoke your consent to processing information about you. If the information processed about you is incorrect, you are entitled to alter or delete this. Inquiry may be made to Kahramanmaraş Teknokent(see contact details under data controller). If you would like to complain about our processing of your personal information, you also have the opportunity to lodge a complaint with your national Data Protection Authority (DPA).',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Publisher and data processor',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'The website is managed, published and data processed by:',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Kahramanmaraş Teknokent',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text(
                          'Avşar Mahallesi, Batı Çevre Yolu Bulvarı, D:No: 259, ',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('46040',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('Onikişubat/Kahramanmaraş',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('https://teknokentmaras.com/',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('bilgi@teknokentmaras.com',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1),
                      Text('+90 (344) 300 1897',
                          style: TextStyle(fontSize: 16),
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
                    "ACCEPT",
                    style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ));
  }

  void showCopyrightDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "SURVEYS' COPYRIGHT",
                style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Text("1. TEACHERS' SURVEY ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "European Framework for the Digital Competence of Educators: DigCompEdu by the European Commission's Joint Research Centre, EUR 28775 EN, ISBN 978-92-79-73494-6, doi:10.2760/159770, JRC107466, http://europa.eu/!gt63ch.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "The survey is translated into Latvian, Slovenian, Macedonian, Romanian, Greek languages and European Commission is not responsible for the translation.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Turkish survey:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "The survey in Turkish is adapted from Toker et al. (2021) Digital Competency Scale for Educators: Adaptation, Validity and Reliability Study. Journal of National Education 50(230), 301-328. European Commission is not responsible for the translation.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text("2. STUDENTS' SURVEY",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Carretero Gomez, S., Vuorikari, R. and Punie, Y., DigComp 2.1: The Digital Competence Framework for Citizens with eight proficiency levels and examples of use, EUR 28558 EN, Publications Office of the European Union, Luxembourg, 2017, ISBN 978-92-79-68006-9 (pdf),978-92-79-68005-2 (print),978-92-79-74173-9 (ePub), doi:10.2760/38842 (online),10.2760/836968 (print),10.2760/00963 (ePub), JRC106281.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "The survey is translated into Slovenian, Macedonian, Romanian, Greek, Turkish and European Commission is not responsible for the translation.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text("3. EMPLOYERS' SURVEY",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "Carretero Gomez, S., Vuorikari, R. and Punie, Y., DigComp 2.1: The Digital Competence Framework for Citizens with eight proficiency levels and examples of use, EUR 28558 EN, Publications Office of the European Union, Luxembourg, 2017, ISBN 978-92-79-68006-9 (pdf),978-92-79-68005-2 (print),978-92-79-74173-9 (ePub), doi:10.2760/38842 (online),10.2760/836968 (print),10.2760/00963 (ePub), JRC106281.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "The survey is adapted and translated into Latvian, Slovenian, Macedonian, Romanian, Greek, Turkish languages and European Commission is not responsible for the translation.",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.justify,
                          textScaleFactor: 1),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "ACCEPT",
                    style: TextStyle(color: Colors.yellow[800], fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ));
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
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            currentTheme.switchTheme();
          },
          label: const Text(
            'Theme',
          ),
          icon: const Icon(
            Icons.brightness_6,
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: const Text(
                  'To create a highly skilled workforce with the digital and technological competencies that employers expect through changes in teaching methodology, the inclusion of new technology in lessons and the design of a new curriculum.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              const Text(
                'The specific objectives of the project are:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '-to invest in the necessary digital and technological materials and equipment to meet industry demands,',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '-to identify the digital and technical skills gaps in the youth of Kahramanmaraş and partner countries by the creation of a comprehensive Skills Competency Map,',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '-to prepare students for the workforce,',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '-to increase awareness about "Education 4.0"',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: value,
                    onChanged: (val) {
                      setState(() {
                        _isButtonDisabled = val!;
                        value = val;
                      });
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'I accept the ',
                          style: const TextStyle(color: Colors.grey),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Privacy and Cookie Policy',
                          style: const TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showPrivacyDialog(context);
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Surveys' Copyright",
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showCopyrightDialog(context);
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              _loadingLanguages
                  ? const Center(child: CircularProgressIndicator())
                  : DropdownButton<String>(
                      value: codeLang,
                      items: languages!
                          .map((e) => DropdownMenuItem(
                              value: e.codeLang, child: Text(e.languageName!)))
                          .toList(),
                      onChanged: (value) {
                        setState(() => codeLang = value!);
                        MyApp.setLocale(context, Locale(value!, 'en'));
                      },
                    ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
                width: 300,
                child: Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: raisedButtonStyle,
                        onPressed: () {
                          !_isButtonDisabled
                              ? showCustomOkDialog(
                                  context,
                                  "Warning !",
                                  "Please accept the Privacy and Cookie Policy.",
                                  "OK")
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirstPage(
                                            codeLang: codeLang,
                                          )),
                                );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Let's Start",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_rounded,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/cc.png"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "This work is licensed under a ",
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                                'Creative Commons Attribution 4.0 International License.',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                launchUrl(Uri.parse(
                                    "https://creativecommons.org/licenses/by/4.0/"));
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
