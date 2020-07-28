import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:first_flutter_app/components/activeWorkouts.dart';
import 'package:first_flutter_app/components/workoutList.dart';
import 'package:first_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'addWorkout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var navBar = CurvedNavigationBar(
      items: const <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search)
      ],
      index: 0,
      height: 50,
      color: Colors.white24,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.5),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index){
        setState(() => sectionIndex = index);
      },
    );

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
        body: sectionIndex == 0 ? ActiveWorkouts() : WorkoutsList(),
        bottomNavigationBar: navBar,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.white,
          foregroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => AddWorkout()));
          },
        ),
      ),
    );
  }
}