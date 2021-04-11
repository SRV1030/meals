import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';

import '../widgets/main_Drawer.dart';
class TabsScreen extends StatefulWidget {

  List<Meal> favouriteMeals;
 TabsScreen(this.favouriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  
   List <Map<String,Object>> _pages;
int _selectedPageIndex=0;
void _selectPage(int index){//automatically receives index
    setState(() {
      _selectedPageIndex=index;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    _pages=[
    {'page':CategoriesScreen(), 'title':'Categories'},
    {'page':FavouritesScreen(widget.favouriteMeals),'title':'Favourites'},
  ];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey,
        currentIndex: _selectedPageIndex,//tells the navigationbar whicjh index is chosen
        // type: BottomNavigationBarType.shifting, //for shifting animation
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text("Favourites"),
          )
        ],
      ),
    );
  }
}

///////////////////
//creating tab at bottom
// return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//             title: Text('MealApp'),
//             bottom: TabBar(
//               tabs: <Widget>[
//                 Tab(
//                   icon: Icon(Icons.category),
//                   text: 'Categories',
//                 ),
//                 Tab(
//                   icon: Icon(Icons.star),
//                   text: 'favorites',
//                 )
//               ],
//             ),
//             ),
//             body: TabBarView(children: <Widget>[
//               CategoriesScreen(),
//               FavouritesScreen(),
//             ],),
//       ),
//     );
//   }
