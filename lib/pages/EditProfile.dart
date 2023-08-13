// ignore_for_file: file_names, use_build_context_synchronously
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/database.dart';
import '../components/styles.dart' as style;
import 'package:flutter_application_1/class/Account.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'EditProfile';

  const EditProfile({Key? key}) : super(key: key);

  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  bool isSmartPhotos = false;
  bool isShare = false;

  String image = '';
  String name = MongoDatabase.myAcc.info.name == '' ? '' : MongoDatabase.myAcc.info.name;
  
  late DateTime birthday;

  @override
  void initState() {
    super.initState();
    if (MongoDatabase.myAcc.info.birthday != '') {
      birthday = DateTime.parse(MongoDatabase.myAcc.info.birthday);
    } else {
      birthday = DateTime.now();
    }
  }
  
  String address = MongoDatabase.myAcc.info.address== '' ? '' : MongoDatabase.myAcc.info.address;
  String phoneNumber = MongoDatabase.myAcc.info.phoneNumber == '' ? '' : MongoDatabase.myAcc.info.phoneNumber;
  String job = MongoDatabase.myAcc.info.job == '' ? '' : MongoDatabase.myAcc.info.job;
  String sexualOrentation = MongoDatabase.myAcc.info.sexualOrentation== '' ? 'Other' : MongoDatabase.myAcc.info.sexualOrentation;
  String describe = MongoDatabase.myAcc.info.describe == '' ? 'Set your description' : MongoDatabase.myAcc.info.describe;
  String gender = MongoDatabase.myAcc.info.gender== '' ? 'Other' : MongoDatabase.myAcc.info.gender;

  String temp = MongoDatabase.myAcc.info.gender== '' ? 'Other' : MongoDatabase.myAcc.info.gender;
  String object = MongoDatabase.myAcc.info.sexualOrentation== '' ? 'Other' : MongoDatabase.myAcc.info.sexualOrentation;
  int age = 0;

  int selectGender = 1;
  String dropdownValue = MongoDatabase.myAcc.info.gender==''?'Other':MongoDatabase.myAcc.info.gender;

  List<String> hobbies = ['Reading', 'Swimming', 'Cooking', 'Traveling', 'Gaming', 'Coding', 'Football', 'Badminton', 'Sleeping', 'Eating',
                            'Drinking', 'Basketball', 'Pet'];
  List<String> selectHobbies = MongoDatabase.myAcc.info.hobby;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 243, 243),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context,'');
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
                title: const Text('Choose your birthday'),
                subtitle: Text(DateFormat('yyyy-MM-dd').format(birthday)),
                
                // subtitle: Text('${birthday.toLocal()}'.split(' ')[0]),
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
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.address== '' ? 'Enter your address' : MongoDatabase.myAcc.info.address),
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
                    gender = value.toString();
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                decoration: inputFieldDecoration(gender),
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
                    sexualOrentation = value.toString();
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                decoration: inputFieldDecoration(sexualOrentation),
              ),
              _buildBoldFont('About You'),
              TextField(
                // controller: Des,
                maxLines: 4,
                decoration: inputFieldDecoration(MongoDatabase.myAcc.info.describe == '' ? 'Set your description' : MongoDatabase.myAcc.info.describe),
                onChanged: (value) {
                  setState(() {
                    describe = value;
                  });
                },
              ),
              _buildBoldFont('Hobbies'),
              
              Container(
                padding: const EdgeInsets.symmetric(),
                color: Colors.white, 
                child: Wrap(
                  spacing: 20, 
                  runSpacing: 10,
                  
                  children: hobbies.map((hobby) {
                    final isSelected = selectHobbies.contains(hobby);

                    return Padding(
                      
                      padding: const EdgeInsets.only(top:10, bottom: 10, left: 10),
                      child: ElevatedButton(
                        onPressed: () {
                            setState(() {          
                              if (isSelected) {
                                selectHobbies.remove(hobby);
                              } else {
                                selectHobbies.add(hobby);
                              }
                            });
                          },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            isSelected ? Colors.pinkAccent : Colors.grey,
                          ),
                        ),
                        child: Text(hobby),      
                      )
                    );
                  }).toList(),
                ),
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
                        onPressed: () async{
                          Person p =MongoDatabase.myAcc.info;
                          DateTime currentDate = DateTime.now();
                          age = currentDate.year - birthday.year;
                          if (currentDate.month < birthday.month ||
                                          (currentDate.month == birthday.month && currentDate.day < birthday.day)) {
                            age--;
                          }

                          int day = birthday.day;
                          int month = birthday.month;
                          int year = birthday.year;
                          String monthStr = (month < 10) ? '0$month' : month.toString();
                          String dayStr = (day < 10) ? '0$day' : day.toString();

                          String birthString = '$year-$monthStr-$dayStr';
                          
                          image = 'assets/images/Unknown_person.jpg';
                          p.set(name, age ,birthString, address, gender, phoneNumber, job, sexualOrentation, describe, image, selectHobbies);
                          await MongoDatabase.updateInfo(MongoDatabase.myAcc.username, p);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),   
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20), 
                            width: 200, 
                            backgroundColor: Colors.pink,
                                
                            shape: RoundedRectangleBorder(  
                              borderRadius: BorderRadius.circular(10),
                            ),
                            behavior: SnackBarBehavior.floating,
                            content: const Text("Updated Successfully", textAlign: TextAlign.center),
                          ),
                        );
                        
                        Navigator.pop(context,'refresh');                       
                      }       
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
            color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold),
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
