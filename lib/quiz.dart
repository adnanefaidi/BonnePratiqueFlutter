import 'package:flutter/material.dart';

class Quiz extends StatefulWidget {
  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int currentQuestion = 0;
  int score = 0;

  final quiz = [
    {
      'title': 'Question 1',
      'answers': [
        {'answer': 'Answer 11', 'correct':false},
        {'answer': 'Answer 12', 'correct':false},
        {'answer': 'Answer 13', 'correct':true}
      ]
    },
    {
      'title': 'Question 2',
      'answers': [
        {'answer': 'Answer 21', 'correct':false},
        {'answer': 'Answer 22', 'correct':true},
        {'answer': 'Answer 23', 'correct':false}
      ]
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        backgroundColor: Colors.deepPurple,
      ),
      body: (this.currentQuestion >= quiz.length)?Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Score : ${(score/quiz.length*100).round()} %', style: TextStyle(color: Colors.black, fontSize: 22)
            ),
            RaisedButton(
              color: Colors.deepPurpleAccent,
              onPressed: () {
                setState(() {
                  currentQuestion = 0;
                  score = 0;
                });
              },
              child: Text('Restart ...', style: TextStyle(color: Colors.white, fontSize: 22)
              ),
            )
          ],
        ),
      )
      : ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text('Question : ${currentQuestion+1}/${quiz.length}', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
            ),
          ),
          ListTile(
            title: Text('${quiz[currentQuestion]['title']} ?', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          ...(quiz[currentQuestion]['answers'] as List<Map<String, Object>>).map((answer) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color: Colors.deepPurpleAccent,
                onPressed: () {
                  setState(() {
                    if(answer['correct'] == true) ++score;
                    ++this.currentQuestion;
                  });
                },
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(answer['answer'], style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              ),
            );
          })
        ],
      )
    );
  }
}

