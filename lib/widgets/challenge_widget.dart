import 'package:flutter/material.dart';

class ChallengeWidget extends StatefulWidget {
  final String title;
  final bool isCompleted;

  ChallengeWidget({@required this.title, @required this.isCompleted});

  @override
  ChallengeWidgetState createState() => ChallengeWidgetState();
}

class ChallengeWidgetState extends State<ChallengeWidget> {

  bool challengeCompleted = false;

  void initState() {
    super.initState();
    challengeCompleted = widget.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //switchChanged(bloc);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: challengeCompleted ? Colors.green : Colors.red,
            ),
            borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Opacity(
            opacity: challengeCompleted ? 0.4 : 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 22,
                    color: challengeCompleted ? Colors.green : Colors.red,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      challengeCompleted ? 'Completed' : 'Not completed',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        color: challengeCompleted ? Colors.green : Colors.red,
                      ),
                    ),
                    _getCheckMarkIfCompleted(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCheckMarkIfCompleted() {
    return challengeCompleted
        ? Image.asset('assets/check.png', height: 40, width: 40)
        : Container();
  }
/*
  Future switchChanged() async {
    await db.update(widget.title, !challengeCompleted ? 1 : 0);
    bloc.checkChallenge.add(widget.title);
    setState(() {
      challengeCompleted = !challengeCompleted;
    });
  }
*/
}
