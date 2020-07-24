import 'package:first_flutter_app/components/workoutList.dart';
import 'package:first_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';

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
class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int sectionIndex = 0;

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
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center),
                title: Text('My workouts')
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Find workouts')
            ),
          ],
          currentIndex: 0,
          backgroundColor: Colors.white,
          onTap: (int index){
            setState(() => sectionIndex = index);
          },
        ),
      ),
    );
  }
}