
import 'package:flutter_application_1/class/Account.dart';
import 'package:flutter_application_1/class/database.dart';
import '/pages/profile.dart';
import '/pages/EditProfile.dart';
// import '/pages/setting.dart';
import 'package:flutter/material.dart';
import '../components/styles.dart' as style;
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class MyProfile extends StatefulWidget {
  static const String id = 'MyProfile';

  const MyProfile({Key? key}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  
  // double deviceWidth;
  int tabID = 1;
  bool val1 = true;
  bool val2 = true;
  bool isShare = false;
  String name = MongoDatabase.myAcc.info.name;
  String address = MongoDatabase.myAcc.info.address;
  int age = MongoDatabase.myAcc.info.age;
  String job = MongoDatabase.myAcc.info.job;
  String describe = MongoDatabase.myAcc.info.describe;
  String gender = MongoDatabase.myAcc.info.gender;
  List<String> hobby = MongoDatabase.myAcc.info.hobby;
  String sexualOrentation = MongoDatabase.myAcc.info.sexualOrentation;
  String phoneNumber = MongoDatabase.myAcc.info.phoneNumber;
  String image = MongoDatabase.myAcc.info.image;
  List<Account> friends = [];
  String imageUrl = MongoDatabase.myAcc.info.image;
  void changeData(){
    setState(() {
      name = MongoDatabase.myAcc.info.name;
      address = MongoDatabase.myAcc.info.address;
      age = MongoDatabase.myAcc.info.age;
      job = MongoDatabase.myAcc.info.job;
      describe = MongoDatabase.myAcc.info.describe;
      gender = MongoDatabase.myAcc.info.gender;
      hobby = MongoDatabase.myAcc.info.hobby;
      sexualOrentation = MongoDatabase.myAcc.info.sexualOrentation;    
      phoneNumber = MongoDatabase.myAcc.info.phoneNumber;
      image = MongoDatabase.myAcc.info.image;
      imageUrl = MongoDatabase.myAcc.info.image;
    });
  }
  @override
  void initState() {
    super.initState();
    getListFriend();
  }
  void getListFriend(){
    List<Account> accounts=MongoDatabase.accounts;
    for (var i = 0; i < accounts.length; i++){
      if(MongoDatabase.myAcc.info.chattingPersons.contains(accounts[i].username)){
        friends.add(accounts[i]);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
     
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').doc(MongoDatabase.myAcc.username).collection('images').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator(); // Display a loading indicator
            }
          
            imageUrl = snapshot.data!.docs.isNotEmpty
                ? snapshot.data!.docs.first['downloadURL'] as String
                : ''; 
       
              return Container(
                width: double.infinity,
                height: 450,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover),
                )
          );
         },
        ),
        Positioned(
            bottom: 10,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: InkWell(
                onTap: () async {

                 String refresh = await Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                 if (refresh == 'refresh')
                 {
                    changeData();
                 }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Text(
                    "Edit info",
                    style: TextStyle(
                        fontSize: 16,
                        color: style.appColor,
                        fontFamily: "medium"),
                  ),
                ),
              ),
            )),
      ],
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
                      Text(
                        name,
                        style: const TextStyle(fontSize: 22, fontFamily: "bold"),
                      ),
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

          const SizedBox(height: 16),
          const Text(
            'Friends',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),

          Text(
              '${friends.length.toString()} friends',
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey, fontFamily: "medium")),
          Column(
            children: [       
              const SizedBox(height: 5),
              Wrap(
                spacing: 30, 
                runSpacing: 10,

                  children: friends.map((friend) {
                    return InkWell(
                      onTap: () async {
                          await Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(personInfo: friend)));
                        },
                      child: Column(
                        children: [
                          Container(
                            width: 105,
                            height:  105,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),                 
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 105,
                            child: Text(
                              friend.info.name,
                              textAlign: TextAlign.left,
                              maxLines: 3, // Allow 2 lines of wrapping
                              overflow: TextOverflow.ellipsis, 
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black, fontFamily: "medium")),  
                          ),
                                            
                        ],
                      ),
                    );
                  }).toList(),             
                )
        
            ],
          )

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
