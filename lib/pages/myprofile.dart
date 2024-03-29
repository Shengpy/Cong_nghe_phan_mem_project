
import 'package:flutter_application_1/class/database.dart';

import '/pages/EditProfile.dart';
import '/pages/setting.dart';
import 'package:flutter/material.dart';
import '../components/styles.dart' as style;

class MyProfile extends StatefulWidget {
  static const String id = 'MyProfile';

  const MyProfile({Key? key}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  List<String> images = [
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/4.jpg',
  ];
  // double deviceWidth;
  int tabID = 1;
  bool val1 = true;
  bool val2 = true;
  bool isShare = false;

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
        Container(
          width: double.infinity,
          height: 450,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(MongoDatabase.myAcc.info.image),
                fit: BoxFit.cover),
          ),
        ),
        // Positioned(
        //     child: Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.only(top: 30),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //           icon: const Icon(
        //             Icons.chevron_left,
        //             color: Colors.white,
        //             size: 40,
        //           ),
        //           onPressed: () {
        //             Navigator.pop(context);
        //           }),
        //     ],
        //   ),
        // )),
        Positioned(
            bottom: 10,
            left: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Setting()));
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: const Icon(
                    Icons.settings_outlined,
                    color: style.appColor,
                  ),
                ),
              ),
            )),
        Positioned(
            bottom: 10,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
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
                        MongoDatabase.myAcc.info.name,
                        style: const TextStyle(fontSize: 22, fontFamily: "bold"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(MongoDatabase.myAcc.info.address,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: "medium")),
                      ),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: buildIconButton(),
                child: Text(MongoDatabase.myAcc.info.age.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "semi-bold",
                      fontSize: 12,
                    )),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
          const Icon(Icons.school, color: Colors.grey),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              MongoDatabase.myAcc.info.job,
              style: const TextStyle(
                  fontSize: 16, color: Colors.grey, fontFamily: "medium"),
            ),
          )
            ],
          ),
          // Row(
          //   children: const [
          // Icon(Icons.category_outlined, color: Colors.grey),
          // Padding(
          //   padding: EdgeInsets.only(left: 10),
          //   child: Text(
          //     "Music, Traveling, Netflix",
          //     style: TextStyle(
          //         fontSize: 16, color: Colors.grey, fontFamily: "medium"),
          //   ),
          // )
          //   ],
          // ),
          const SizedBox(height: 16),
          const InkWell(
            child: Text(
              'About',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 5),
          Text(
              MongoDatabase.myAcc.info.describe,
              style: const TextStyle(
                  fontSize: 14, color: Colors.grey, fontFamily: "medium")),
          Container(
            margin: const EdgeInsets.only(top: 20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                InkWell(
                  child: Row(
                    children:[
                      Text(
                        MongoDatabase.myAcc.info.gender,
                        style: const TextStyle(
                          color: style.appColor,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                const Expanded(
                    child: Text("Show my age",
                        style: TextStyle(
                            fontFamily: "semi-bold",
                            fontSize: 16,
                            color: Colors.black87))),
                Switch(
                  activeColor: style.appColor,
                  value: isShare,
                  onChanged: (value) {
                    setState(() {
                      isShare = value;
                      // print(isShare);
                    });
                  },
                )
              ],
            ),
          ),
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

class Item {
  const Item(this.name, this.icn);
  final IconData icn;
  final String name;
}
