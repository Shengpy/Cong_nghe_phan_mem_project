// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/database.dart';
import '../components/styles.dart' as style;

class EditProfile extends StatefulWidget {
  static const String id = 'EditProfile';

  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  bool isSmartPhotos = false;
  bool isShare = false;
  final TextEditingController _controllerDescribe = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerBirth = TextEditingController();
  final TextEditingController _controllerLocation = TextEditingController();
  String image = '';
  String name = '';
  DateTime birthday = DateTime.now();
  String address = '';
  String phoneNumber = '';
  String job = '';
  String sexualOrentation = '';
  String describe = '';
  String gender = '';
  String temp = 'Male';
  String object = 'Male';

  String option = (MongoDatabase.myAcc.info.birthday == '' ? 'Choose your date of birth' : MongoDatabase.myAcc.info.birthday);
  RangeValues distance = const RangeValues(40, 80);
  RangeValues age = const RangeValues(40, 80);
  int selectGender = 1;
  String dropdownValue = MongoDatabase.myAcc.info.gender==''?'Other':MongoDatabase.myAcc.info.gender;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.chevron_left,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Edit Profile',
          style: TextStyle(color: style.appColor, fontFamily: "semi-bold"),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(MongoDatabase.myAcc.info.image),
                          radius: 70,
                          
                        ),
                        Positioned(
                            bottom: 5,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(100),
                                  ),
                                  border: Border.all(
                                      width: 3, color: Colors.white)),
                              child: const Icon(Icons.camera_alt, size: 16),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(MongoDatabase.myAcc.info.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20)),
                    ),
                  ],
                ),
              ),
              _buildBoldFont('Name'),
              TextFormField(
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.name == '' ? 'Enter full name' : MongoDatabase.myAcc.info.name),
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
              _buildBoldFont('Date of birth'),
              ListTile(
                tileColor: Colors.white,
                
                title: Text(option),
                subtitle: Text('${birthday.toLocal()}'.split(' ')[0]),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: birthday,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null && pickedDate != birthday) {
                    setState(() {
                      birthday = pickedDate;
                    });
                  }
                },
              ),
              _buildBoldFont('Location'),
              TextFormField(
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.address == '' ? 'Enter your address' : MongoDatabase.myAcc.info.address),
                onChanged: (value) {
                  setState(() {
                    address = value;
                  });
                },
              ),
              _buildBoldFont('Gender'),
              DropdownButtonFormField(
                
                value: temp,
                onChanged: (value) {
                  setState(() {
                    temp = value.toString();
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.gender),
              ),
              _buildBoldFont('Phone number'),
              TextFormField(
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.phoneNumber == '' ? 'Enter your phone number' : MongoDatabase.myAcc.info.phoneNumber),
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
              ),
              _buildBoldFont('Occupation'),
              TextFormField(
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.job == '' ? 'Enter your job' : MongoDatabase.myAcc.info.job),
                onChanged: (value) {
                  setState(() {
                    job = value;
                  });
                },
              ),
              _buildBoldFont('Sexual Orientation'),
              DropdownButtonFormField(                
                value: object,
                onChanged: (value) {
                  setState(() {
                    object = value.toString();
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.gender),
              ),
              _buildBoldFont('About You'),
              TextField(
                // controller: Des,
                maxLines: 4,
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.describe == '' ? 'Set your description' : MongoDatabase.myAcc.info.describe),
              ),
              _buildBoldFont('Other'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Don \'t Show My Age',
                        style: TextStyle(fontSize: 16)),
                    Switch(
                      value: isSmartPhotos,
                      activeColor: style.appColor,
                      onChanged: (value) {
                        setState(() {
                          isSmartPhotos = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              //------------------------------My dinstance
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text('Make My Distance Invisible',
                        style: TextStyle(fontSize: 16)),
                    Switch(
                      value: isSmartPhotos,
                      activeColor: style.appColor,
                      onChanged: (value) {
                        setState(() {
                          isSmartPhotos = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              //----------------------------------
              Container(
                padding: const EdgeInsets.symmetric(vertical: 27),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:[
                    Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 45),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,            
                          textStyle: const TextStyle(fontSize: 20), 
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20), 
                        ),
                        child: const Text('Update'),
                        onPressed: (){
                          // Person p = Person();
                          // DateTime currentDate = DateTime.now();
                          // int age = currentDate.year - birthday.year;
                          // if (currentDate.month < birthday.month ||
                          //                 (currentDate.month == birthday.month && currentDate.day < birthday.day)) {
                          //   age--;
                          // }

                          // String day = birthday.day;
                          // String month = birthday.month;
                          // String year = birthday.year;

                          // birth_string = year + '-' + month + '-' + day;
                          // p.set(name, age ,birth_string, address, gender, phoneNumber, job, sexualOrentation, describe, image);
                          // MongoDatabase.updateInfo(MongoDatabase.myAcc.username, p);
                        },
                      )
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void hehe(){}
  Widget _buildSelect() {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Men', 'Woman', 'Other']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  myBoxDecoration() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)));
  }

  Widget _buildBoldFont(text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        '$text',
        style: const TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  inputFieldDecoration(text) {
    return InputDecoration(
        hintText: '$text',
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none);
  }

  textButton() {
    return const TextStyle(
        color: Colors.white, fontFamily: 'semi-bold', fontSize: 12);
  }
}