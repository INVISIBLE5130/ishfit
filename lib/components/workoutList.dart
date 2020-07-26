import 'package:first_flutter_app/domain/workout.dart';
import 'package:flutter/material.dart';

class WorkoutsList extends StatefulWidget {
  @override
  _WorkoutsListState createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {
  @override
  void initState() {
    clearFilter();
    super.initState();
  }

  final workouts = <Workout>[
    Workout(
        title: 'test1',
        author: 'Ihor1',
        description: 'Test workout1',
        level: 'Beginner'
    ),
    Workout(
        title: 'test2',
        author: 'Ihor2',
        description: 'Test workout2',
        level: 'Pre-Intermediate'
    ),
    Workout(
        title: 'test3',
        author: 'Ihor3',
        description: 'Test workout3',
        level: 'Intermediate'
    ),
    Workout(
        title: 'test4',
        author: 'Ihor4',
        description: 'Test workout4',
        level: 'Advanced'
    ),
    Workout(
        title: 'test5',
        author: 'Ihor5',
        description: 'Test workout5',
        level: 'Professional'
    )
  ];

  var filterMyWorkouts = false;
  var filterTitle = '';
  var filterTitleController = TextEditingController();
  var filterLevel = 'All levels';

  var filterText = '';
  var filterHeight = 0.0;

  List<Workout> filter() {
    setState(() {
      filterText = filterMyWorkouts ? 'My workouts ' : 'All workouts';
      filterText += filterLevel;
      if(filterTitle.isNotEmpty) filterText += '/' + filterTitle;
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  List<Workout> clearFilter() {
    setState(() {
      filterText = 'All workouts / All levels';
      filterMyWorkouts = false;
      filterTitle = '';
      filterLevel = 'All levels';
      filterTitleController.clear();
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var workoutsList = Expanded(
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i){
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                decoration: BoxDecoration(color: Colors.teal),
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

    var filterInfo = Container(
      margin: EdgeInsets.only(top: 3, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      height: 40,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(Icons.filter_list),
            Text(
              filterText,
              style: TextStyle(),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            filterHeight = (filterHeight == 0.0 ? 280.0 : 0.0);
          });
        },
      ),
    );

    var levelMenuItems = <String>[
      'All levels',
      'Beginner',
      'Pre-Intermediate',
      'Intermediate',
      'Advanced',
      'Professional'
    ].map((String value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();

    var filterForm = AnimatedContainer(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('My workouts'),
                value: filterMyWorkouts,
                onChanged: (bool val) => setState(() => filterMyWorkouts = val)
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Level'
                ),
                items: levelMenuItems,
                value: filterLevel,
                onChanged: (String val) => setState(() => filterTitle = val),
              ),
              TextFormField(
                controller: filterTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (String val) => setState(() => filterTitle = val),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        filter();
                      },
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: () {
                        clearFilter();
                      },
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      color: Colors.red,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
    );

    return Column(
      children: <Widget>[
        filterInfo,
        filterForm,
        workoutsList,
      ],
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