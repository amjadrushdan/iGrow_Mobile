import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

class BookingDetail extends StatelessWidget{
  const BookingDetail({key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: size.height*0.024,
            ),
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text('Workshop 1', style: TextStyle(
              color: Colors.white, fontSize: size.width*0.04,
            ))
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.width*0.05,
                vertical: size.height*0.03,
              ),
              margin: const EdgeInsets.only(top: 20),
              width:double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: Workshop 1', style: TextStyle(fontSize: size.width*0.044, 
                  fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*0.02),
                  Row(children: [
                    
                    Text('Description: Workshop 1 about type of plants and soil tutorial', style: TextStyle(
                      fontSize: size.width*0.03,
                    ),),
                  ],),
                  SizedBox(height: size.height*0.02,),
                ],)
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width*0.05,
                  vertical: size.height*0.03,
                ),
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
                child: Row(children: [
                  Text('Session 1:', style: TextStyle(fontSize: size.width*0.034, fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*0.02,),
                  Row(children: [
                    Text(' 24/11/2021', style: TextStyle(fontSize: size.width*0.034,),),
                  ],),
                  SizedBox(height: size.height*0.034,),
                    Text(' 10:00 AM - 12:00 PM',)
                ],),
                ),

                Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width*0.05,
                  vertical: size.height*0.03,
                ),
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
                child: Row(children: [
                  Text('Session 2:', style: TextStyle(fontSize: size.width*0.034, fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*0.02,),
                  Row(children: [
                    Text(' 2/12/2021', style: TextStyle(fontSize: size.width*0.034,),),
                  ],),
                  SizedBox(height: size.height*0.034,),
                    Text(' 2:00 PM - 5:00 PM',)
                ],),
                ),

                Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width*0.05,
                  vertical: size.height*0.03,
                ),
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
                child: Row(children: [
                  Text('Session 3:', style: TextStyle(fontSize: size.width*0.034, fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*0.02,),
                  Row(children: [
                    Text(' 14/1/2022', style: TextStyle(fontSize: size.width*0.034,),),
                  ],),
                  SizedBox(height: size.height*0.034,),
                    Text(' 2:00 PM - 5:00 PM',)
                ],),
                ),
                Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width*0.05,
                  vertical: size.height*0.03,
                ),
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
                child: Row(children: [
                  Text('Session 4:', style: TextStyle(fontSize: size.width*0.034, fontWeight: FontWeight.bold),),
                  SizedBox(height: size.height*0.02,),
                  Row(children: [
                    Text(' 30/1/2022', style: TextStyle(fontSize: size.width*0.034,),),
                  ],),
                  SizedBox(height: size.height*0.034,),
                    Text(' 10:00 AM - 1:00 PM',)
                ],),
                ),
                SizedBox(height: 160,),
                RoundedButton(
                text: "Apply",
                
                press: () {
                
                  }
                ),
        ],)
    );

    
  }

}
