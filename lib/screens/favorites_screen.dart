import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavouritesScreen extends StatelessWidget {
  List<Meal> favouriteMeal;
  FavouritesScreen(this.favouriteMeal);
  @override
  Widget build(BuildContext context) {
    if (favouriteMeal.isEmpty){
      return Center(
      child: Text("No favourites yet!!"),
    );
    }
    else{
      return  ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              title: favouriteMeal[index].title,
              id:favouriteMeal[index].id,
              imageURL:favouriteMeal[index].imageUrl,
              duration: favouriteMeal[index].duration,
              complexity: favouriteMeal[index].complexity,
              affordability: favouriteMeal[index].affordability,
              );
        },
        itemCount: favouriteMeal.length,
      );   
    }
  }
}
