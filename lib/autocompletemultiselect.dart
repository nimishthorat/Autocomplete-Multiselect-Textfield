library autocompletemultiselect;
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AutocompleteMultiselect extends StatefulWidget {

  final List<dynamic> suggestions;

  AutocompleteMultiselect({@required this.suggestions});

  @override
  _AutocompleteMultiselectState createState() => _AutocompleteMultiselectState();
}

class _AutocompleteMultiselectState extends State<AutocompleteMultiselect> {
  bool _isItemSelected = false;
  List<dynamic> _myItems = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: AutoCompleteTextField<String>(
              suggestions: widget.suggestions,
//                  controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                hintText: "Select Items to add in Combo",
                hintStyle: TextStyle(color: Colors.black),
              ),
              itemFilter: (item, query){
                return item.toLowerCase().contains(query.toLowerCase());
              },
              itemSorter: (a, b){
                return a.compareTo(b);
              },
              itemSubmitted: (value){
                print(value);
                setState(() {
                  _isItemSelected = true;
//                      _searchController.text = value;
                  _myItems.add(value);
                });
              },
              itemBuilder: (context,item){
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(item),
                );
              },
            ),
          ),
          _isItemSelected
              ? Padding(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey[200]
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: List.generate(_myItems.length, (index) => Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (){
                      if(_myItems.length == 0)
                        setState(() {
                          _isItemSelected = false;
                        });
                      else{
                        _myItems.removeAt(index);
                        setState(() {

                        });
                      }
                    },
                    child: Card(
                      elevation: 2,
                      color: Colors.grey,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(_myItems.elementAt(index), style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ),
                )
                ),
              ),
            ),
          )
              : Container(),
        ],
      ),
    );
  }
}

