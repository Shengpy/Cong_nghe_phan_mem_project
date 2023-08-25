import 'package:flutter/material.dart';
import 'package:flutter_application_1/class/Account.dart';
import '../components/styles.dart' as style;
import 'package:flutter_application_1/class/database.dart';


class Profile extends StatefulWidget {
  static const String id = 'FriendProfile';

  final Account personInfo;
  const Profile({super.key,required this.personInfo});

  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  int tabID = 1;
  bool val1 = true;
  bool val2 = true;
  bool isShare = false;
  //set here
  String name = '';
  String address = '';
  int age = 0;
  String job = '';
  String describe = '';
  String gender = '';
  List<String> hobby = [];
  String sexualOrentation = '';
  String phoneNumber ='';
  String image = '';

  @override
  void initState() {
    super.initState();
    
    updateState(widget.personInfo);
  }

  void updateState(Account personInfo) {
    setState(() {
      name = personInfo.info.name;
      address = personInfo.info.address;
      age = personInfo.info.age;
      job = personInfo.info.job;
      describe = personInfo.info.describe;
      gender = personInfo.info.gender;
      hobby = personInfo.info.hobby;
      sexualOrentation = personInfo.info.sexualOrentation;
      phoneNumber = personInfo.info.phoneNumber;
      image = personInfo.info.image;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text(
          "$name's Profile",
          style: TextStyle(color: style.appColor, fontFamily: "semi-bold"),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black87),
        elevation: 0,
        actions: [
        IconButton(
          onPressed: () {
            // Navigate to report page
            //!!!report user personInfo
          },
          icon: const Icon(
            Icons.report,
            size: 30,
          ),
        ),
      ],
      ),
      backgroundColor: Colors.grey[200],
      body: _buildBody(),
      
    );
  }
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCarousel(),
          _ProfileDesc(),
        ],
      ),
    );
  }
  
  Widget _buildCarousel() {
    return Stack(
      children: [ 
        
        // Container(
                 
        //         width: double.infinity,
        //         height: 450,
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: NetworkImage(image),
        //             fit: BoxFit.cover),
        //         )
        // ),
        Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Column(
                  children: [
                          CircleAvatar(
                              backgroundImage: NetworkImage(image),
                              radius: 100,
                          ),
                        
                         Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 25)),
                        ),
                      ],
                    ),        
                  ),
        ]
    );
  }
  // ignore: non_constant_identifier_names
  Widget _ProfileDesc() {
    return Container(
      
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            
            children: <Widget>[
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    
                      const SizedBox(height: 16),
                      Row(
                        children: [
                      const Icon(Icons.location_on_sharp, color: Colors.pink),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          address,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.grey, fontFamily: "medium"),
                        ),
                      )
                        ],
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: buildIconButton(),
                
                child: Text(age.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "semi-bold",
                      fontSize: 15,
                      
                      
                    )),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
          const Icon(Icons.work, color: Colors.pink),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              job,
              style: const TextStyle(
                  fontSize: 16, color: Colors.grey, fontFamily: "medium"),
            ),
          )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              
          const Icon(Icons.person, color: Colors.pink),       
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              gender,
              style: const TextStyle(
                  fontSize: 16, color: Colors.grey, fontFamily: "medium"),
            ),
          )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              
          const Icon(Icons.phone, color: Colors.pink),
          
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              phoneNumber,
              style: const TextStyle(
                  fontSize: 16, color: Colors.grey, fontFamily: "medium"),
            ),
          )
            ],
          ),
          const SizedBox(height: 16),
          const InkWell(
            child: Text(
              'Hobbies',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            hobby.join(', '), 
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontFamily: "medium"
            ),
          ),
          const SizedBox(height: 16),
          const InkWell(
            child: Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 5),
          Text(
              describe,
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey, fontFamily: "medium")),

        ],
      ),
    );
  }

  buildIconButton() {
    return const BoxDecoration(
        color: style.appColor,
        borderRadius: BorderRadius.all(Radius.circular(30)));
  }
}

