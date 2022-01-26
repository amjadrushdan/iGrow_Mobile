import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

class BookF {
  String filter_title;
  bool isSelected;
  BookF(this.filter_title, this.isSelected);
}

class FilterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterScreenState();
  }
}

class FilterScreenState extends State<FilterScreen> {
  List<String> selected = List.empty(growable: true);
  List<BookF> filter_state = [
    BookF("Johor", false),
    BookF("Negeri Sembilan", false),
    BookF("Pulau Pinang", false),
    BookF("Terengganu", false),
    BookF("Kedah", false),
    BookF("Pahang", false),
    BookF("Sabah", false),
    BookF("Kuala Lumpur", false),
    BookF("Kelantan", false),
    BookF("Perak", false),
    BookF("Sarawak", false),
    BookF("Melaka", false),
    BookF("Perlis", false),
    BookF("Selangor", false),
  ];

  List<BookF> filter_soil = [
    BookF("Clay", false),
    BookF("Sandy", false),
    BookF("Silty", false),
    BookF("Peaty", false),
    BookF("Chalky", false),
    BookF("Loamy", false),
    BookF("Others", false),
  ];

  List<BookF> filter_plant = [
    BookF("Rose", false),
    BookF("Lily", false),
    BookF("Hibiscus", false),
    BookF("Violet", false),
    BookF("Ixora", false),
    BookF("Anthurium", false),
    BookF("Daisy", false),
    BookF("Lotus", false),
    BookF("Canna", false),
    BookF("Orchid", false),
    BookF("Jasmine", false),
    BookF("Tulip", false),
    BookF("Others", false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 75,
        leading: MaterialButton(
            onPressed: () {
              Navigator.pop(context, "");
            },
            child: Text("Cancel", style: TextStyle(color: Colors.white))),
        backgroundColor: kPrimaryColor,
        actions: [
          MaterialButton(
            onPressed: () {
              if (selected.isNotEmpty) {
                Map<String, dynamic> filters = Map();
                filters['cat'] = (selected);
                Navigator.pop(context, jsonEncode(filters));
              }
            },
            child: Text(
              "Apply Filter",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text("Filter By State", style: TextStyle(color: Colors.blue)),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8,
                  direction: Axis.horizontal,
                  children: techChips(filter_state, Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Filter By Soil", style: TextStyle(color: Colors.blue)),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8,
                  direction: Axis.horizontal,
                  children: techChips(filter_soil, Colors.blue),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Filter By Plants", style: TextStyle(color: Colors.blue)),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 8,
                  direction: Axis.horizontal,
                  children: techChips(filter_plant, Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> techChips(List<BookF> _chipsList, color) {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          selectedColor: kPrimaryColor,
          label: Text(_chipsList[i].filter_title),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: color,
          selected: _chipsList[i].isSelected,
          checkmarkColor: Colors.white,
          onSelected: (bool value) {
            if (value) {
              selected.add(_chipsList[i].filter_title);
            } else {
              selected.remove(_chipsList[i].filter_title);
            }
            setState(
              () {
                _chipsList[i].isSelected = value;
              },
            );
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
