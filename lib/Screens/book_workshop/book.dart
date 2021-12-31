import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'book_detail.dart';
import 'package:flutter_auth/constants.dart';

class BookingPage extends StatefulWidget {
  @override
  Booking createState() => Booking();
  }

class Booking extends State<BookingPage> {
     Future getPosts() async {
     var firestore = FirebaseFirestore.instance;

     QuerySnapshot qn = await firestore.collection('booking').get();
     return qn.docs;
   }

   navigateToDetail(DocumentSnapshot post) {
     Navigator.push(context,
        MaterialPageRoute(builder: (context) => BookingDetail(post: post)));
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(backgroundColor: kPrimaryColor,
     title: Text("Booking Workshop",),),
     body: Container(
       child: FutureBuilder(
       future: getPosts(),
       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
         if (snapshot.connectionState == ConnectionState.waiting) {
           return Center(child: CircularProgressIndicator(),);
         } else {
           return ListView.separated(separatorBuilder: (context, index) => Divider(color: Colors.black,),
           itemCount: snapshot.data.length,
           itemBuilder: (_, index) {
             return ListTile(
               title: Text(snapshot.data[index]['programmename']),
               subtitle: Text(snapshot.data[index]['date']),
               onTap: () => navigateToDetail(snapshot.data[index]),
             );
           },
           );
         }
       },

     ),),
   );
  }
}