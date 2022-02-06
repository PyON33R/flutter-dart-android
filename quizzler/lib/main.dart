import 'package:flutter/material.dart';
import 'quizbrain.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          title: const Text(
            "Project - QuizApp",
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 25.0,
              color: Colors.white70,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey.shade800,
        ),
        body: const QuizPage(),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> scoreKeeper = [];
  int score = 0;
  int questionIndex = 0;
  QuizBrain quizBrain = QuizBrain();

  void doBtnAction(bool inp) {
    if (questionIndex < quizBrain.getQuestionListLen()) {
      var correctAnswer = quizBrain.getAnswer(questionIndex);
      if (correctAnswer == inp) {
        scoreKeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
        score++;
      } else {
        scoreKeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      setState(() {
        questionIndex++;
      });
      // ignore: avoid_print
      print(questionIndex);
    }
  }

  String questionOut() {
    if (questionIndex < quizBrain.getQuestionListLen()) {
      return quizBrain.getQuestion(questionIndex);
    } else {
      String scoreOut = score.toString();
      return 'Score: $scoreOut';
    }
  }

  Expanded btnTrueFalse(String btnText, Color btnColor, bool b) {
    Expanded btn = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white70,
            backgroundColor: btnColor,
          ),
          onPressed: () {
            doBtnAction(b);
          },
          child: Text(
            btnText,
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );

    return btn;
  }

  Expanded btnRestart() {
    Expanded btn = Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.white70,
            backgroundColor: Colors.teal,
          ),
          onPressed: () {
            setState(() {
              score = 0;
              scoreKeeper = [];
              questionIndex = 0;
            });
          },
          child: const Text(
            'Restart Quiz',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
        ),
      ),
    );

    return btn;
  }

  List<Widget> setChildren() {
    if (questionIndex < quizBrain.getQuestionListLen()) {
      return [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                questionOut(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
        btnTrueFalse("True", Colors.green, true),
        btnTrueFalse("False", Colors.red, false),
        Row(
          children: scoreKeeper,
        )
      ];
    } else {
      return [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                questionOut(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ),
        btnRestart(),
        Row(
          children: scoreKeeper,
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: setChildren(),
      ),
    );
  }
}
