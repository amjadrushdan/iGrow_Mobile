import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/constants.dart';

class BookingDetail extends StatelessWidget{
  List<String> items = <String>[
    'Select', 'Session 1: 24/11/2021 10:00 AM - 12:00 PM', 
    'Session 2: 2/12/2021 2:00 PM - 5:00 PM',
    'Session 3: 14/1/2022 2:00 PM - 5:00 PM',
    'Session 4: 30/1/2022 10:00 AM - 1:00 PM',
    
  ];
  String dropdownValue = 'Select';
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
              SizedBox(height: 27,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select session', style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
                Container(
                  padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
                  child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    onChanged: (String? newValue){
                      setState(() {
                        dropdownValue = newValue!;
                      }
                      );
                    },
                    value: dropdownValue,
                    items: items.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                          );
                      },
                    ).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 380,),
                RoundedButton(
                
                text: "Apply",
                
                press: () {
                
                  }
                ),
        ],)
    );

    
  }
  void showAlertDialog(BuildContext context) => showDialog(
    builder: (context) => AlertDialog(
      title: Text('Testing'),
      content: Text('Trying'),
      actions: [
        OutlineButton(
          onPressed:() => Navigator.of(context).pop(),
          child: Text('Confirm'),
           )
      ],
    ), context: context
    );


  void setState(Null Function() param0) {}

}
