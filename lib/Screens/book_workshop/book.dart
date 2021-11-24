import 'dart:ffi';

import 'package:flutter/material.dart';
import 'book_detail.dart';
import 'package:flutter_auth/constants.dart';

class Booking extends StatelessWidget {
const Booking({key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
    body:Column(
      
      children: [
        const SizedBox(height: 24),
        Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height*0.024,
            ),
            alignment: Alignment.center,
            width:double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text('Booking Workshop', style: TextStyle(
              color: Colors.white, fontSize: size.width*0.045,
            ))
          ),
          const SizedBox(height: 5),
          Container (
            padding: EdgeInsets.symmetric(
              
            ),
            color: Colors.white,
            child: Material(
            child: ListTile(
            title: const Text('List of Workshop', style: TextStyle(fontWeight: FontWeight.bold)),
            tileColor: Colors.white,
  
    ),
  ),

          ),
          Container (
        
            padding: EdgeInsets.symmetric(
            ),
            color: Colors.white,
            child: Material(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              title: Text(
                "Workshop 1",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text("Description about workshop 1",
                      style: TextStyle(color: Colors.black))
                ],
              ),
              trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  
                  icon: Icon(
                  Icons.arrow_forward_ios,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                  context,
                        MaterialPageRoute(builder: (context) => BookingDetail()),
                      );
                },
              ),
            ],
            ),
            ),
           ),

          ),
          Container (
            padding: EdgeInsets.symmetric(
              
            ),
            color: Colors.white,
            child: Material(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              title: Text(
                "Workshop 1",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text("Description about workshop 1",
                      style: TextStyle(color: Colors.black))
                ],
              ),
              trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  
                  icon: Icon(
                  Icons.arrow_forward_ios,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                  context,
                        MaterialPageRoute(builder: (context) => BookingDetail()),
                      );
                },
              ),
            ],
            ),
            ),
  ),
          ),
          Container (
            padding: EdgeInsets.symmetric(
              
            ),
            color: Colors.white,
            child: Material(
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              title: Text(
                "Workshop 1",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: <Widget>[
                  Text("Description about workshop 1",
                      style: TextStyle(color: Colors.black))
                ],
              ),
              trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  
                  icon: Icon(
                  Icons.arrow_forward_ios,
                  color: kPrimaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                  context,
                        MaterialPageRoute(builder: (context) => BookingDetail()),
                      );
                },
              ),
            ],
            ),
            ),
  ),

          )
      ],)
      );
  }
}