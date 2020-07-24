import 'package:first_flutter_app/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../domain/workout.dart';

void main() => runApp(FirstFlutterApp());

class FirstFlutterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IshFit',
        theme: ThemeData(
            primaryColor: Colors.blueGrey,
            textTheme: TextTheme(title: TextStyle(color: Colors.white))
        ),
        home: HomePage()
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('IshFit'),
          leading: Icon(Icons.fitness_center),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: (){
                  AuthService().logOut();
                },
                icon: Icon(
                  Icons.supervised_user_circle,
                  color: Colors.white
                ),
                label: SizedBox.shrink()
            )
          ],
        ),
        body: WorkoutsList(),
      ),
    );
  }
}

class WorkoutsList extends StatelessWidget {
  final workouts = <Workout>[
    Workout(title: 'test1', author: 'Ihor1', description: 'Test workout1', level: 'Beginner'),
    Workout(title: 'test2', author: 'Ihor2', description: 'Test workout2', level: 'Pre-Intermediate'),
    Workout(title: 'test3', author: 'Ihor3', description: 'Test workout3', level: 'Intermediate'),
    Workout(title: 'test4', author: 'Ihor4', description: 'Test workout4', level: 'Advanced'),
    Workout(title: 'test5', author: 'Ihor5', description: 'Test workout5', level: 'Professional')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i){
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                decoration: BoxDecoration(color: Colors.lightBlue),
                child: ListTile(
                  leading: Container(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(Icons.fitness_center, color: Theme.of(context).textTheme.title.color),
                    decoration: BoxDecoration(
                        border: Border(right: BorderSide(width: 1, color: Colors.white30))
                    ),
                  ),
                  title: Text(
                    workouts[i].title,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.title.color,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).textTheme.title.color,),
                  subtitle: subtitle(context, workouts[i]),
                ),
              ),
            );
          }
      ),
    );
  }
}

Widget subtitle(BuildContext context, Workout workout) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch(workout.level) {
    case 'Beginner':
      color = Colors.blue;
      indicatorLevel = 0.2;
      break;
    case 'Pre-Intermediate':
      color = Colors.green;
      indicatorLevel = 0.4;
      break;
    case 'Intermediate':
      color = Colors.yellow;
      indicatorLevel = 0.6;
      break;
    case 'Advanced':
      color = Colors.orange;
      indicatorLevel = 0.8;
      break;
    case 'Professional':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }

  return Row(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).textTheme.title.color,
          value: indicatorLevel,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: Text(workout.level, style: TextStyle(color: Theme.of(context).textTheme.title.color)),
      )
    ],
  );
}