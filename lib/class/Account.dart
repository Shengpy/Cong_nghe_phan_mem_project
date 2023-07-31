// ignore_for_file: file_names
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'Account.g.dart';

@JsonSerializable(explicitToJson: true)
class Account{
  late String username;
  late String password;
  late Person info;
  
  Account({this.username='',this.password='',email=''}){
    info=Person(email:email);
  }
  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

@JsonSerializable()
class Person{
  String name='';
  int age;
  String gentle='';
  String email='';
  String address='';
  String phoneNumber='';
  String education='';
  String sexualOrentation='';
  String describe='';
  // @HiveType(typeId: 1)
  // late List<Person> favoritePersons;
  String image='assets/images/Unknown_person.jpg';
  
  Person({this.name='',this.age=0,this.email=''});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
  void updateImage(String a){image=a;}
  void updateGentle(String a){gentle=a;}
  void setName(String a){name=a;}
  bool setAge(int a){
    if(a<=0){
      return false;
    }
    age=a;
    return true;
  }
  void setDescribe(String a){describe=a;}
  // bool addPersons(Person a){
  //   if(favoritePersons.contains(a)){return false;}
  //   favoritePersons.add(a);
  //   return true;
  // }
}