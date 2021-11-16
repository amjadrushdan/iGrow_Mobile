// ignore_for_file: non_constant_identifier_names

import 'dart:convert';


class LoginPerson {
  final String Email;
  final String Password;
  final String Username;
  final String Name; 
  final String DateOfBirth;
  final int Age; 
  final String District; 
  final String State; 
  final String Occupation; 
  final String About; 
  final String Gender; 
  final String MaritalStatus; 
  final String UserLevel;
  
  LoginPerson({
    this.Email,
    this.Password,
    this.Username,
    this.Name,
    this.DateOfBirth,
    this.Age,
    this.District,
    this.State,
    this.Occupation,
    this.About,
    this.Gender,
    this.MaritalStatus,
    this.UserLevel,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is LoginPerson &&
      other.Email == Email &&
      other.Password == Password &&
      other.Username == Username &&
      other.Name == Name &&
      other.DateOfBirth == DateOfBirth &&
      other.Age == Age &&
      other.District == District &&
      other.State == State &&
      other.Occupation == Occupation &&
      other.About == About &&
      other.Gender == Gender &&
      other.MaritalStatus == MaritalStatus &&
      other.UserLevel == UserLevel;
  }

  @override
  int get hashCode {
    return Email.hashCode ^
      Password.hashCode ^
      Username.hashCode ^
      Name.hashCode ^
      DateOfBirth.hashCode ^
      Age.hashCode ^
      District.hashCode ^
      State.hashCode ^
      Occupation.hashCode ^
      About.hashCode ^
      Gender.hashCode ^
      MaritalStatus.hashCode ^
      UserLevel.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'Email': Email,
      'Password': Password,
      'Username': Username,
      'Name': Name,
      'DateOfBirth': DateOfBirth,
      'Age': Age,
      'District': District,
      'State': State,
      'Occupation': Occupation,
      'About': About,
      'Gender': Gender,
      'MaritalStatus': MaritalStatus,
      'UserLevel': UserLevel,
    };
  }

  factory LoginPerson.fromMap(Map<String, dynamic> map) {
    return LoginPerson(
      Email: map['Email'],
      Password: map['Password'],
      Username: map['Username'],
      Name: map['Name'],
      DateOfBirth: map['DateOfBirth'],
      Age: map['Age'],
      District: map['District'],
      State: map['State'],
      Occupation: map['Occupation'],
      About: map['About'],
      Gender: map['Gender'],
      MaritalStatus: map['MaritalStatus'],
      UserLevel: map['UserLevel'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginPerson.fromJson(String source) => LoginPerson.fromMap(json.decode(source));
}
