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
  String birthday='';
  String gender='Other';
  String email='';
  String address='';
  String phoneNumber='';
  String job='';
  String sexualOrentation='';
  String describe='';
  String image='assets/images/Unknown_person.jpg';
  List<String> likedMe=[];
  List<String> myFavorites=[];
  List<String> hobby=[];
  List<String> chattingPersons=[];

  Person({this.name='',this.age=0,this.email=''});
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
  void updateImage(String a){image=a;}
  void updateGender(String a){gender=a;}
  void setName(String a){name=a;}
  bool setAge(int a){
    if(a<=0){
      return false;
    }
    age=a;
    return true;
  }
  void setDescribe(String a){describe=a;}
  void set(String name, int age, String birthday, String address,String gender, 
            String phoneNumber,String job,  String sexualOrentation, String describe, String image,  List<String> hobby){
    this.name = name;
    this.age = age;
    this.birthday = birthday;
    this.address = address;
    this.gender = gender;
    this.phoneNumber = phoneNumber; 
    this.job = job;
    this.sexualOrentation = sexualOrentation;
    this.describe = describe;
    this.image = image;
    this.hobby = hobby;
  }
}