import 'package:flutter/material.dart';

import '../dummy_data .dart';

import '../models/meal.dart';

import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  // // final String categoryId;
  // // final String  categoryTitle;

  // CategoryMealsScreen({this.categoryId,this.categoryTitle});
  
  static String routeName = '/categories-meals';
  final List<Meal> avilableMEals;
  CategoryMealsScreen(this.avilableMEals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData=false;

  

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(!_loadedInitData){
      final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final String categoryId = routeArgs['id'];
    displayedMeals = widget.avilableMEals;
    _loadedInitData=true;

    }
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final String categoryId = routeArgs['id'];
    displayedMeals = widget.avilableMEals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedInitData=true;

    super.didChangeDependencies();
  }
  // void _removeMeal(String mealId)
  // {
  //   setState(() {
  //     displayedMeals.removeWhere((meal) => meal.id==mealId);
  //   });

  // }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              title: displayedMeals[index].title,
              id: displayedMeals[index].id,
              imageURL: displayedMeals[index].imageUrl,
              duration: displayedMeals[index].duration,
              complexity: displayedMeals[index].complexity,
              affordability: displayedMeals[index].affordability,
              // removeItem: _removeMeal we used this to remove meal with Navigator.pop,                           
              );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
