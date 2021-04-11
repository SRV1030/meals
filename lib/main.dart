import "package:flutter/material.dart";


import './dummy_data .dart';
import './models/meal.dart';

import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/FiltersScreen.dart';
import './screens/categories_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegeterian':false,    
  };
List<Meal> _favouriteMeal=[];
List<Meal> _avilableMeals= DUMMY_MEALS;



void _setFilters(Map<String,bool> filteredData){
  setState(() {
    _filters=filteredData;
    _avilableMeals= DUMMY_MEALS.where((meal){
      if(_filters['gluten'] && !meal.isGlutenFree) return false;
      if(_filters['lactose'] && !meal.isLactoseFree) return false;
      if(_filters['vegan'] && !meal.isVegan) return false;
      if(_filters['vegeterian'] && !meal.isVegetarian) return false;
      return true;
    }).toList();
  });
}
void _toggleFavourite(String mealId){
 final existingIndex = _favouriteMeal.indexWhere((meal) => meal.id==mealId);
 if(existingIndex>=0){
   setState(() {
     _favouriteMeal.removeAt(existingIndex);     
   });
 }
   else{
     _favouriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));

   }
 }
bool _isMealFavourite(String id){
  return _favouriteMeal.any((meal) => meal.id==id);//any returns if any element satisfies the condn
}


  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Meals App",
      theme: ThemeData(
          primarySwatch: Colors.cyan,
          accentColor: Colors.white,
          canvasColor: Color.fromRGBO(227, 220, 220, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: "RobotoCondensed",
                fontWeight: FontWeight.bold,
              ))),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favouriteMeal),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_avilableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavourite,_isMealFavourite),
        FilterScreen.routename: (ctx) => FilterScreen(_filters,_setFilters),
      },
      onGenerateRoute: (settings) {
        //used if route is randomly generated
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
      onUnknownRoute: (settings) {
        //used when none of the above routes work. can be used as 404 error page
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}
