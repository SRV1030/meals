import 'package:flutter/material.dart';
import '../widgets/main_Drawer.dart';

class FilterScreen extends StatefulWidget {
  static final String routename = '/filters';
  final Function saveFilters;
  final Map<String,bool> currentfilters;
  FilterScreen(this.currentfilters,this.saveFilters);
   

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegeterian = false;
  var _lactoseFree = false;
  
  @override
  initState(){
    _glutenFree = widget.currentfilters['gluten'];
  _vegan = widget.currentfilters['vegan'];
  _vegeterian = widget.currentfilters['vegeterian'];
  _lactoseFree = widget.currentfilters['lactose'];
    super.initState();

  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final _selectedfilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegeterian': _vegeterian,
                };
                widget.saveFilters(_selectedfilters);//we use widget cz it is not defined in state bu in app
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal Selcetion',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-Free',
                  'Only include Gluten-Free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        _glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-Free',
                  'Only include Lactose-Free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegeterian',
                  'Only include Vegeterian meals.',
                  _vegeterian,
                  (newValue) {
                    setState(
                      () {
                        _vegeterian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include Vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
