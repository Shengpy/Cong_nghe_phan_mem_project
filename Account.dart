
class Account{
  late String username;
  late String password;
  late Person info;
  
  
  String getUsername(){
    return this.username;
  }
}

class Person{
  late String name;
  late DateTime birthday;
  late String address;
  late String phoneNumber;
  late String education;
  late String sexualOrentation;
  late String describe;
  late String gender;
  
  Person(){
    this.name = '';
    this.birthday = DateTime.now();
    this.address = '';
    this.phoneNumber = '';
    this.education = '';
    this.sexualOrentation = '';
    this.gender = '';
    this.describe = '';
  }

  void set(String name, DateTime birthday, String address, String phoneNumber, String education,  String sexualOrentation, String describe, String gender)
  {
    this.name = name;
    this.birthday = birthday;
    this.address = address;
    this.phoneNumber = phoneNumber;
    this.education = education;
    this.sexualOrentation = sexualOrentation;
    this.gender = gender;
    this.describe = describe;
  }

  
}